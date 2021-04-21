import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddUserInfo {
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<DocumentReference> addNewCustomUser({required User user, required String username}) async {
    return users.add({
      'email': user.email,
      'username': username,
      'id': user.uid,
      'profilepic': user.photoURL,
      'timestamp': user.metadata.creationTime,
      'completedUser': false,
    });
  }
}
