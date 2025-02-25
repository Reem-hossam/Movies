import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/Login%20Screen/Login%20Screen.dart';
import 'package:movies_app/home/home.dart';

import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/";
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/movies_posters.png",
      "title": "Find Your Next Favorite Movie Here",
    },
    {
      "image": "assets/images/onboarding_1.png",
      "title": "Discover Movies",
      "button": "Next"
    },
    {
      "image": "assets/images/onboarding_2.png",
      "title": "Explore All Genres",
      "button": "Next"
    },
    {
      "image": "assets/images/onboarding_3.png",
      "title": "Create Watchlists",
      "button": "Next"
    },
    {
      "image": "assets/images/onboarding_5.png",
      "title": "Rate, Review, and Learn",
      "button": "Next"
    },
    {
      "image": "assets/images/onboarding_4.png",
      "title": "Start Watching Now",
      "button": "Finish"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 1,
              autoPlay: false,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: onboardingData.map((item) {
                image: item["image"]!,
                title: item["title"]!,
                description: item["description"]!,
                buttonText: item["button"]!,
                onNextButton: () {
                  if (_currentIndex < onboardingData.length - 1) {
                    _carouselController.nextPage();
                  } else {
                  }
                },
                onBackButton: () {
                  if (_currentIndex < onboardingData.length) {
                    _carouselController.previousPage();
                  }
                },
            }).toList(),
          ),
        ],
      ),
    );
  }
}
