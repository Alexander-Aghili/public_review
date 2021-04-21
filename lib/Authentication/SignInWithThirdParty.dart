import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:public_review/Authentication/GoogleSignIn.dart';
import 'package:public_review/User/AddUserInfo.dart';

class SignInWithThirdParty {
  void addNewUser() {}

  Future<void> signInWithGoogle() async {
    User user;

    final UserCredential userCredential =
        await PublicReviewGoogleSignIn().signInWithGoogle();
    //Account already exists
    if (await CheckInfoFromDatabase()
        .emailExists(userCredential.user!.email.toString())) {
      return;
    }
    user = userCredential.user!;
    AddUserInfo().addNewCustomUser(user: user, username: user.displayName.toString());
  }

  Future<void> doNothing() async {}
}

class CheckInfoFromDatabase {
  Future<bool> emailExists(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    return result.docs.isNotEmpty;
  }
}
