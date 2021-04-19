import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserInfo {
  String email;
  String username;

  AddUserInfo({required this.email, required this.username});

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<void> addNewUser() {
    return users.add({
      'email': email,
      'username': username,
    });
  }
}
