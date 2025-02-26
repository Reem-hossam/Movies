import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movies_app/home/tabs/browes.dart';
import 'package:movies_app/home/tabs/home%20tap.dart';
import 'package:movies_app/home/tabs/profile%20tab/profile_tab.dart';

import 'tabs/search tab.dart';

class Home extends StatefulWidget {
  static const String routeName="Home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/tab_icons/home.png"),color: Colors.white,), label: "Home"),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/tab_icons/search.png"),color: Colors.white), label: "search"),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/tab_icons/explore.png"),color: Colors.white), label: "Browse"),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/tab_icons/profile.png"),color: Colors.white), label: "Profile"),
          ]
      ),
      body:tabs[currentIndex],
    );
  }
}
List<Widget>tabs=[
  HomeTab(),
  SearchTab(),
  Browse(),
  ProfileTab(),


];