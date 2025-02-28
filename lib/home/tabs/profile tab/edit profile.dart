import 'package:flutter/material.dart';
import 'package:movies_app/Login%20Screen/forget_password.dart';
import 'package:movies_app/firebase/firebase_manager.dart';


class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = "UpdateProfileScreen";

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedAvatar = "assets/images/avatar1.png";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    var user = await FirebaseManager.readUser();
    if (user != null) {
      setState(() {
        nameController.text = user.name;
        phoneController.text = user.phoneNumber;
        selectedAvatar = user.avatar;
      });
    }
  }

  void updateProfile() async {
    try {
      await FirebaseManager.updateUser(
        nameController.text,
        selectedAvatar,
        phoneController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile Updated Successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile")),
      );
    }
  }

  void deleteAccount() async {
    try {
      await FirebaseManager.deleteUserAccount();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account Deleted Successfully!")),
      );
      Navigator.pushReplacementNamed(context, "/login");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete account")),
      );
    }
  }

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
          child: SingleChildScrollView(
            child: GridView.builder(
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
                      color: selectedAvatar == avatars[index]
                          ? Color.fromRGBO(246, 189, 0, 0.56)
                          : Colors.transparent,
                      border: Border.all(
                        color: Color.fromRGBO(246, 189, 0, 1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(avatars[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Avatar", style: TextStyle(color: Colors.yellow)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70),
            GestureDetector(
              onTap: () => AvatarSelection(context),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(selectedAvatar),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Theme.of(context).inputDecorationTheme.iconColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Name",
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Theme.of(context).inputDecorationTheme.iconColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Phone Number",
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, ForgetPassword.routeName);
              },
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Reset Password",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: deleteAccount,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text("Delete Account",
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateProfile,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Update Data"),
            ),
          ],
        ),
      ),
    );
  }
}
