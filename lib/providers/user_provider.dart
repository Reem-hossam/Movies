import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_manager.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userModel = await FirebaseManager.readUser();
    notifyListeners();
  }
  Future<void> updateUser(String name, String avatar) async {
    if (firebaseUser == null)
      return;
    await FirebaseManager.updateUser(name, avatar);
    userModel?.name = name;
    userModel?.avatar = avatar;
    notifyListeners();
  }
}
