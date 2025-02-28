import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/task_model.dart';
import '../model/user_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, options) {
        return user.toJson();
      },
    );
  }

  static Future<void> addUser(UserModel user) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    await docRef.set(user);
  }

  static Future<UserModel?> readUser() async {
    var collection = getUsersCollection();
    DocumentSnapshot<UserModel> docRef =
    await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docRef.data();
  }

  static Future<void> createAccount(
      String name,
      String emailAddress,
      String password,
      String avatar,
      String phoneNumber,
      Function onLoading,
      Function onSuccess,
      Function onError) async {
    try {
      onLoading();

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (credential.user != null) {
        UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: emailAddress,
          avatar: avatar,
          phoneNumber: phoneNumber,
        );

        await addUser(userModel);

        onSuccess();
      } else {
        onError("Failed to create user.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError("The password is too weak.");
      } else if (e.code == 'email-already-in-use') {
        onError("The email is already in use. Please use a different email.");
      } else {
        onError("Something went wrong: ${e.message}");
      }
    } catch (e) {
      onError("Something went wrong.");
      print("Error in createAccount: $e");
    }
  }

  static Future<void> login(
      String email,
      String password,
      Function onLoading,
      Function onSuccess,
      Function onError) async {
    try {
      onLoading();

      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        onSuccess();
      } else {
        onError("Login failed. Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        onError("Wrong password provided.");
      } else {
        onError("Something went wrong: ${e.message}");
      }
    } catch (e) {
      onError("Something went wrong.");
      print("Error in login: $e");
    }
  }
  static Future<void> updateUser(String name, String avatar, String phoneNumber) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection("Users").doc(user.uid).update({
      "name": name,
      "avatar": avatar,
      "phoneNumber": phoneNumber,
    });
  }


  static Future<void> deleteUserAccount() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection("Users").doc(user.uid).delete();

    await user.delete();
  }
}
