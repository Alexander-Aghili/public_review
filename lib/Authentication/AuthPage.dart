import 'package:flutter/material.dart';
import 'package:public_review/Authentication/SignInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget pageForUserState() {
    if (auth.currentUser != null) {
      return Scaffold();
    } else {
      return SignInPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return pageForUserState();
  }
}
