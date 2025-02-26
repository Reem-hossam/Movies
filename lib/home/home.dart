import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movies_app/home/tabs/browes.dart';
import 'package:movies_app/home/tabs/home%20tap.dart';
import 'package:movies_app/home/tabs/profile%20tab/profile_tab.dart';

import 'tabs/search tab.dart';

class Home extends StatefulWidget {
  static const String routeName = "Home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
              selectedIconTheme:
                  IconThemeData(color: Theme.of(context).primaryColor),
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              currentIndex: currentIndex,
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/tab_icons/home.png"),
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/tab_icons/search.png"),
                    ),
                    label: "search"),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/tab_icons/explore.png"),
                    ),
                    label: "Browse"),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/tab_icons/profile.png"),
                    ),
                    label: "Profile"),
              ]),
        ),
      ),
      body: tabs[currentIndex],
    );
  }
}

List<Widget> tabs = [
  HomeTab(),
  SearchTab(),
  Browse(),
  ProfileTab(),
];
