import 'package:firebase_auth/firebase_auth.dart';

class CustomAuth {
  
  Future<String> signIn(String email, String password) async {
    try {
      
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e);
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }
}
