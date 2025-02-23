import 'package:flutter/material.dart';

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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(icon: Icon(Icons.compass_calibration_rounded), label: "Browse"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
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