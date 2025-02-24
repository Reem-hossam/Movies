import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/Login%20Screen/Login%20Screen.dart';
import 'package:movies_app/home/home.dart';

import 'onboarding_page.dart';



class OnboardingScreen extends StatefulWidget {
  static const String routeName="/";
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/movies_posters.png",
      "title": "Find Your Next Favorite Movie Here",
      "description": "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      "button": "Explore Now",

    },
    {
      "image": "assets/images/onboarding_1.png",
      "title": "Discover Movies",
      "description": "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      "button": "Next"
    },
    {
      "image": "assets/images/onboarding_2.png",
      "title": "Explore All Genres",
      "description": "Choose movies from every genre, be it action, adventure, drama, or sci-fi.",
      "button": "Next"
    },
    {
      "image": "assets/images/onboarding_3.png",
      "title": "Create Watchlists",
      "description": "Save your favorite movies to a watchlist and enjoy them anytime.",
      "button": "Next"
    },
    {
      "image": "assets/images/onboarding_5.png",
      "title": "Rate, Review, and Learn",
      "description": "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      "button": "Next"
    },
    {
      "image": "assets/images/onboarding_4.png",
      "title": "Start Watching Now",
      "description": "Enjoy top-rated movies from the comfort of your home.",
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
                height:  MediaQuery.of(context).size.height*1,
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
                return
                    OnboardingPage(

                      image: item["image"]!,
                      title: item["title"]!,
                      description: item["description"]!,
                      buttonText: item["button"]!,
                      onNextButton: () {
                        if (_currentIndex < onboardingData.length - 1) {
                          _carouselController.nextPage();
                        } else {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        }
                      },
                      onBackButton: () {
                        if (_currentIndex < onboardingData.length ) {
                          _carouselController.previousPage();
                        }
                      },
                      isLast: _currentIndex == onboardingData.length - 1, firstScreen:true ?_currentIndex==1||_currentIndex==0:false,
                    )


                ;
              }).toList(),
            ),

        ],
      ),
    );
  }
}
