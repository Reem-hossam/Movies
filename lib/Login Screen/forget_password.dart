import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  static const String routeName = "forget-password";
  TextEditingController emailController = TextEditingController();

  ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forget Password",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Color(0xffF6BD00)
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/Forgot_password.png"),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(
                    color: Colors.white
                ),
                prefixIcon: Icon(Icons.email,
                color: Colors.white,),

              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14))),
              child: Text("Verify Email",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}