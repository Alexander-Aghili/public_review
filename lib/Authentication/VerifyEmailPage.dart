import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:public_review/AppOverview/HomePage.dart';

class VerifyEmailPage extends StatefulWidget {
  late String email;

  VerifyEmailPage({required this.email});

  @override
  State<StatefulWidget> createState() => new _VerifyEmailPage(email: email);
}

class _VerifyEmailPage extends State<VerifyEmailPage> {
  User user = FirebaseAuth.instance.currentUser!;
  late String email;
  bool _showResendText = false;
  late Text _verifyText;

  _VerifyEmailPage({required this.email});

  Widget bigEmailText() {
    return Container(
      padding: EdgeInsets.only(top: 75, bottom: 80),
      child: Text(
        "Check Your Email!",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 50,
        ),
      ),
    );
  }

  Widget emailText() {
    return Text(
      "Email: " + email,
      style: TextStyle(color: Colors.black, fontFamily: "Dosis", fontSize: 25),
    );
  }

  Widget verifyEmailContainer() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: _verifyText,
    );
  }

  Text verifyEmailText() {
    return Text(
      "After you have verified your email, click continue.",
      style: TextStyle(color: Colors.black, fontFamily: "Dosis", fontSize: 25),
    );
  }

  Widget emailVerifiedButton() {
    return ElevatedButton(
      onPressed: () => isEmailVerified(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
      ),
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.black, fontSize: 25),
      ),
    );
  }

  void isEmailVerified() async {
    user = FirebaseAuth.instance.currentUser!;
    user.reload();
    
    if (!user.emailVerified) {
      setState(() {
        _verifyText = Text(
            "Email not verified. Check and verify your email. Then continue.");
      });
      await user.sendEmailVerification();
      return;
    }

    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => HomePage()));
  }

  Widget resendVerificationButton() {
    return Container(
      padding: EdgeInsets.only(top: 150),
      child: ElevatedButton(
        onPressed: () => resendVerification(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
          minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
        ),
        child: Text(
          "Resend Verification",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }

  resendVerification() async {
    await user.sendEmailVerification();

    setState(() {
      _showResendText = false;
      Timer(Duration(seconds: 1), () => handleTimeout());
    });
  }

  void handleTimeout() {
    setState(() {
      _showResendText = true;
    });
  }

  Visibility resendEmailText() {
    return Visibility(
      child: Text("Email sent...",
          style: TextStyle(
              color: Colors.black, fontFamily: "Dosis", fontSize: 25)),
      visible: _showResendText,
    );
  }

  @override
  Widget build(BuildContext context) {
    _verifyText = verifyEmailText();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: ListView(
          physics: ScrollPhysics(),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                bigEmailText(),
                emailText(),
                verifyEmailContainer(),
                emailVerifiedButton(),
                resendVerificationButton(),
                resendEmailText(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
