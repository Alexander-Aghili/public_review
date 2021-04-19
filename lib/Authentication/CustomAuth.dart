import 'package:firebase_auth/firebase_auth.dart';

class CustomAuth {
  static signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
