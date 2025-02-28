
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/Login%20Screen/register.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../home/home.dart';

import '../firebase/firebase_manager.dart';
import 'forget_password.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/splash_logo.png",
                  width: 136,
                  height: 186,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    prefixIcon: Icon(Icons.email,
                    color: Colors.white,),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                    prefixIcon: Icon(Icons.lock,
                    color: Colors.white,),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgetPassword.routeName);
                      },
                      child: Text(
                        "Forget Password?",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);

                    // FirebaseManager.login(
                    //   emailController.text,
                    //   passwordController.text,
                    //       () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => const AlertDialog(
                    //         title: Center(child: CircularProgressIndicator()),
                    //         backgroundColor: Colors.transparent,
                    //       ),
                    //     );
                    //   },
                    //       () async {
                    //     Navigator.pop(context);
                    //     await userProvider.initUser();
                    //     Navigator.pushNamedAndRemoveUntil(
                    //       context,
                    //       Home.routeName,
                    //           (route) => false,
                    //     );
                    //   },
                    //       (message) {
                    //     Navigator.pop(context);
                    //     showDialog(
                    //       context: context,
                    //       barrierDismissible: false,
                    //       builder: (context) => AlertDialog(
                    //         title: const Text("Something went Wrong"),
                    //         content: Text(message),
                    //         actions: [
                    //           ElevatedButton(
                    //               onPressed: () {
                    //                 Navigator.pop(context);
                    //               },
                    //               child: const Text("Ok"))
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  child: Text("login",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Color(0xff282A28))),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don’t Have Account ?",
                          style:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: " Create Account",
                          style:
                          Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                          indent: 10,
                          endIndent: 40,
                        )),
                    Text(
                      textAlign: TextAlign.center,
                      "OR",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                    Expanded(
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                          indent: 40,
                          endIndent: 10,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16,),
                    backgroundColor: Color(0xffF6BD00),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(14)),),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png"),
                      SizedBox(width: 8,),
                      Text("Login With Google",
                          style: TextStyle(
                            color: Color(0xff282A28),
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          )),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
