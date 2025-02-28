import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/Login%20Screen/register.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "email".tr(),
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "password".tr(),
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetPassword.routeName);
                    },
                    child: Text(
                      "forget_password".tr(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    FirebaseManager.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                          () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Center(child: CircularProgressIndicator()),
                            backgroundColor: Colors.transparent,
                          ),
                        );
                      },
                          () async {
                        Navigator.pop(context);
                        await userProvider.initUser();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Home.routeName,
                              (route) => false,
                        );
                      },
                          (message) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text("error_title".tr()),
                            content: Text(message),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("ok".tr()),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    "login".tr(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color(0xff282A28),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "no_account".tr(),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: " create_account".tr(),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).primaryColor,
                        indent: 10,
                        endIndent: 40,
                      ),
                    ),
                    Text(
                      "or".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).primaryColor,
                        indent: 40,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xffF6BD00),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png"),
                      const SizedBox(width: 8),
                      Text(
                        "login_google".tr(),
                        style: const TextStyle(
                          color: Color(0xff282A28),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(

                  padding: EdgeInsets.only(left: 140,right:140),
                  child: ToggleSwitch(
                    minWidth: 80,
                    minHeight: 30,
                    initialLabelIndex: context.locale.toString() == "en" ? 0 : 1,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveFgColor: Colors.white,
                    inactiveBgColor: Colors.transparent,
                    totalSwitches: 2,
                    icons: const [
                      Icons.flag,
                      Icons.flag_circle_outlined,
                    ],
                    iconSize: 24.0,
                    activeBgColors: [
                      [Colors.yellow, Colors.orange],
                      [Colors.yellow, Colors.orange],
                    ],
                    animate: true,
                    curve: Curves.easeInOut,
                    borderWidth: 2,
                    borderColor: [Colors.yellow],
                    onToggle: (index) {
                      context.setLocale(index == 0 ? const Locale('en') : const Locale('ar'));
                    },
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
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
