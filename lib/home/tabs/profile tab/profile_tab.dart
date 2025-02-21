import 'package:flutter/material.dart';


import '../../home.dart';
import 'History.dart';
import 'edit profile.dart';
import 'watch list.dart';

class ProfileTab extends StatelessWidget {


  ProfileTab({super.key});
  String selectedAvatar = "assets/avatar1.png";

  @override
  Widget build(BuildContext context) {
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
              backgroundImage: AssetImage(selectedAvatar),
            ),

                Text("Wish List"),
                Text("History"),
          ],
        ),
        SizedBox(height: 15,),
        Text(
         // userProvider.userModel?.name ?? "null",
        "reem",
      textAlign: TextAlign.start,
      ),
        SizedBox(
      height: 23,
      ),
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, UpdateProfileScreen.routeName);
          },style:ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.black,
          ) ,
              child: Text("Edit Profile"),
          ) ,
        ElevatedButton(onPressed: (){
            Navigator.pushNamedAndRemoveUntil(
                context,
                Home.routeName,
                (route)=>false,
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor:Color.fromRGBO(232, 38, 38, 1)
          ),
              child: Text("Exit",style:Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white
                ),
              ),),
        ],
       )

      ],
      ),
        bottom:
        TabBar(
          labelColor:Colors.white,
            indicatorColor: Theme.of(context).primaryColor,
            tabs:[
          Tab(
            icon:Icon(Icons.list_rounded,color:Theme.of(context).primaryColor) ,
            text:"Watch List",
          ),
          Tab(icon:Icon(Icons.folder,color:Theme.of(context).primaryColor ,),
            text:"History",)
        ]
        ),
          ),
        body: TabBarView(
            children:[
              WatchList(),
              History(),
        ]
        ),
      ),
    );
  }
}
