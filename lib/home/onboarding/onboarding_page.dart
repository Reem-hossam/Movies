import 'package:flutter/material.dart';
import 'package:movies_app/theme/app%20theme.dart';

class OnboardingPage extends StatelessWidget {
  final VoidCallback? onNextButton, onBackButton;

  const OnboardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.isLast,
      this.onNextButton,

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
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(title,
                        textAlign: TextAlign.center,
                const SizedBox(height: 10),
                    textAlign: TextAlign.center,
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
                              MediaQuery.of(context).size.height * 0.05)),
                      onPressed: onNextButton,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          buttonText,
                        ),
                      )),
                ),
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                                  MediaQuery.of(context).size.height * 0.05)),
                          onPressed: onBackButton,
                          child: Text(
                            "Back",
                          ),
                        ),
                        height: 0,
                      ),
              ],
          ),
        ),
      ],
    );
  }
}
