import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:public_review/Authentication/SignInPage.dart';
import 'package:public_review/EssentialWidgets/Header.dart';
import 'package:public_review/EssentialWidgets/LoadingAction.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: ElevatedButton(
        onPressed: () => signOut(),
        child: Text('Sign Out'),
      ),
    );
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => SignInPage()));
  }
}
