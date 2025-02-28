import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../firebase/firebase_manager.dart';
import 'Login Screen.dart';


class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  List<String> avatars = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar4.png",
    "assets/images/avatar5.png",
    "assets/images/avatar6.png",
    "assets/images/avatar7.png",
    "assets/images/avatar8.png",
    "assets/images/avatar9.png",
  ];

  String selectedAvatar = "assets/images/avatar1.png";
  void AvatarSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Color.fromRGBO(40, 42, 40, 1),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(19),
          child:
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 19,
              mainAxisSpacing: 17,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatars[index];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedAvatar ==avatars[index]?Color.fromRGBO(246, 189, 0, 0.56)
                        : Colors.transparent,
                    border: Border.all(
                      color: Color.fromRGBO(246, 189, 0, 1),
                      width:1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(avatars[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Color(0xffF6BD00)
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () => AvatarSelection(context),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage(selectedAvatar),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                      prefixIcon: Icon(Icons.person,
                      color: Colors.white,),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is Required";
                      }
                      final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value);


                      if (emailValid == false) {
                        return "Email not Valid";
                      }
                      return null;
                    },
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
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is Required";
                      }
                      if (value.length < 6) {
                        return "Password should be at least 6 Char";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                      suffixIcon: Icon(Icons.visibility_off,
                      color: Colors.white,),
                      prefixIcon: Icon(Icons.lock,
                        color: Colors.white,),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: rePasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirm Password is Required";
                      }
                      if (value.length < 6) {
                        return "Password should be at least 6 Char";
                      }

                      if (passwordController.text != value) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                      suffixIcon: Icon(Icons.visibility_off_sharp,
                      color: Colors.white,),
                      prefixIcon: Icon(Icons.lock,
                        color: Colors.white,),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone Number is Required";
                      }
                      final bool phoneValid = RegExp(
                          r"^\+?[1-9]\d{1,14}$")
                          .hasMatch(value);


                      if (phoneValid == false) {
                        return "phone not Valid";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                      prefixIcon: Icon(Icons.phone,
                      color: Colors.cyan,),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseManager.createAccount(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          selectedAvatar.isNotEmpty ? selectedAvatar : "default_avatar_url",
                          phoneController.text.trim(),
                              () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 10),
                                    Text("Creating account..."),
                                  ],
                                ),
                              ),
                            );
                          },
                              () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                              (message) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Something went wrong"),
                                content: Text(message),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 120),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    child: Text("Create Account",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black)),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Already Have Account ? ",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),
                          ),
                          TextSpan(
                            text: " Login",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
