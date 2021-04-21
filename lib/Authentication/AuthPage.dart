import 'package:flutter/material.dart';
import 'package:public_review/AppOverview/HomePage.dart';
import 'package:public_review/Authentication/SignInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'VerifyEmailPage.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget authChecks() {
    User? user = auth.currentUser;
    if (user != null) {
      user.reload();
    }

    if (user == null) {
      return SignInPage();
    } else if (!user.emailVerified) {
      return VerifyEmailPage(email: user.email.toString());
    } else {
      return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return authChecks();
  }
}
