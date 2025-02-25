import 'package:flutter/material.dart';
import 'package:movies_app/theme/app%20theme.dart';

class OnboardingPage extends StatelessWidget {
  final String image, title, buttonText;
  final String description;
  final VoidCallback? onNextButton, onBackButton;
  final bool isLast, onboardingOne, firstScreen;

  const OnboardingPage(
      {super.key,
        required this.image,
        required this.title,
        required this.description,
        required this.buttonText,
        required this.isLast,
        this.onNextButton,
        this.onBackButton,
        required this.onboardingOne,
        required this.firstScreen});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          image,
          fit: BoxFit.fill,
          height: double.infinity,
        ),
        IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: !firstScreen?AppTheme().background:Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(title,
                        textAlign: TextAlign.center,
                        style: firstScreen?TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ):TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ))),
                const SizedBox(height: 10),
                Text(description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: firstScreen?Color.fromRGBO(255, 255, 255, 0.6):Colors.white,
                    )),
                // const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.8,
                              MediaQuery.of(context).size.height * 0.05)),
                      onPressed: onNextButton,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          buttonText,
                        ),
                      )),
                ),
                !onboardingOne&&!firstScreen
                    ? Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(
                            color: Theme.of(context).primaryColor),
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.8,
                            MediaQuery.of(context).size.height * 0.05)),
                    onPressed: onBackButton,
                    child: Text(
                      "Back",
                    ),
                  ),
                )
                    : SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
