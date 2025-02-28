import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/home/tabs/profile%20tab/edit%20profile.dart';
import 'package:movies_app/home/tabs/profile%20tab/watch%20list.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../home.dart';
import 'History screen.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String selectedAvatar = "assets/images/avatar1.png";
  int historyCounter = 0;
  int watchlistCounter = 0;

  @override
  void initState() {
    super.initState();
    loadWatchListCount();
    loadHistoryListCount();
  }

  Future<void> loadWatchListCount() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchList = prefs.getStringList('watch_list') ?? [];
    setState(() {
      watchlistCounter = watchList.length;
    });
  }

  Future<void> loadHistoryListCount() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historyList = prefs.getStringList('history_posters') ?? [];
    setState(() {
      historyCounter = historyList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          toolbarHeight: 300,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userProvider.userModel?.avatar != null
                        ? AssetImage(userProvider.userModel!.avatar)
                        : AssetImage("assets/images/avatar1.png"),
                  ),
                  Column(
                    children: [
                      Text("$watchlistCounter"),
                      SizedBox(height: 20),
                      Text("Wish List"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("$historyCounter"),
                      SizedBox(height: 20),
                      Text("History"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                userProvider.userModel?.name ?? "null",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, UpdateProfileScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.black,
                    ),
                    child: Text("Edit Profile"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Home.routeName,
                            (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(232, 38, 38, 1),
                    ),
                    child: Text(
                      "Exit",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                icon: Icon(Icons.list_rounded, color: Theme.of(context).primaryColor),
                text: "Watch List",
              ),
              Tab(
                icon: Icon(Icons.folder, color: Theme.of(context).primaryColor),
                text: "History",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WatchListScreen(),
            HistoryScreen(updateHistoryCounter: loadHistoryListCount),  // Pass the counter update function
          ],
        ),
      ),
    );
  }
}
