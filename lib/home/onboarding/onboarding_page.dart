import 'package:flutter/material.dart';
import 'package:movies_app/theme/app%20theme.dart';

class OnboardingPage extends StatelessWidget {
  final String image, title, description, buttonText;
  final VoidCallback? onNextButton, onBackButton;
  final bool isLast, firstScreen;

  const OnboardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.isLast,

       this.onNextButton,
       this.onBackButton, required this.firstScreen});

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
        Container(
          height: MediaQuery.of(context).size.height * 0.33,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: AppTheme().background),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(16),
                  child:Text(title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge)),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                            MediaQuery.of(context).size.height * 0.05)),
                    onPressed: onNextButton,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        buttonText,
                      ),
                    )),
              ),
              !firstScreen ? Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.05)),
                  onPressed: onBackButton,
                  child: Text(
                    "Back",
                  ),
                ),
              ):SizedBox(
                height: 0,
              ),

            ],
          ),
        ),
      ],
    );
  }
}
