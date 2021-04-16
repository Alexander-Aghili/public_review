import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:public_review/Authentication/SignUpPage.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isAppleDevice() {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  Widget topText() {
    return Text(
      "Public Review",
      style: TextStyle(
        fontSize: 55.0,
        color: Colors.black, /*fontFamily: "KScript"*/
      ),
    );
  }

  Widget signInRow(Icon icon, String inputText, bool secureText,
      TextEditingController controller) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          height: 75,
          width: 35,
          alignment: Alignment.center,
          child: icon,
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          height: 75,
          width: 350,
          alignment: Alignment.center,
          child: TextField(
            obscureText: secureText,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: inputText,
            ),
          ),
        ),
      ],
    );
  }

  Widget signInButton() {
    return Container(
      padding: EdgeInsets.only(left: 22),
      child: ElevatedButton(
        onPressed: () => signIn(),
        child: Text("Sign in", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            fixedSize: MaterialStateProperty.all<Size>(Size(335, 50))),
      ),
    );
  }

  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: usernameController.text.trim(),
              password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("no user: " + usernameController.text);
        usernameController.text = "No Email Found:";
        passwordController.clear();
      } else if (e.code == 'wrong-password') {
        print("bad password");
        passwordController.text = "Incorrect Password";
      }
    } catch (e) {}
  }

  Widget signUpButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, bottom: 5),
      child: TextButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage())),
        child: Text("Sign up", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          fixedSize: MaterialStateProperty.all<Size>(Size(300, 50)),
        ),
      ),
    );
  }

  Widget seperateServicesSignInColumn() {
    //bool isApple = isAppleDevice();
    double height = 55;
    bool isApple = true;
    if (isApple) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: height,
            child: signInWithSeperateServiceButton(
                AssetImage("assets/images/google_signin_button.png")),
          ),
          SizedBox(
            height: height,
            child: signInWithSeperateServiceButton(
                AssetImage("assets/images/facebook_signin_button.png")),
          ),
          SizedBox(
            height: height,
            child: signInWithSeperateServiceButton(
                AssetImage("assets/images/twitter_signin_button.png")),
          ),
          SizedBox(
            height: height,
            child: signInWithSeperateServiceButton(
                AssetImage("assets/images/apple_signin_button.png")),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 75,
            child: signInWithSeperateServiceButton(
                AssetImage("assets/images/google_signin_button.png")),
          ),
          SizedBox(
            height: 75,
            child: signInWithSeperateServiceButton(
                AssetImage("assets/images/facebook_signin_button.png")),
          ),
          SizedBox(
            height: 75,
            child: signInWithSeperateServiceButton(
                AssetImage("assets/images/twitter_signin_button.png")),
          ),
        ],
      );
    }
  }

  Widget signInWithSeperateServiceButton(
      /*VoidCallback action,*/ AssetImage image) {
    return GestureDetector(
      onTap: null,
      child: Container(
        //padding: EdgeInsets.all(5),
        width: 270.0,
        height: 65.0,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: image,
        )),
      ),
    );
  }

  Widget orContainer(double height) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Text("OR",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
    );
  }

  Widget skip() {
    return GestureDetector(
      onTap: null,
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 100,
        height: 40,
        child: Text(
          "Skip",
          style: TextStyle(
              color: Colors.amber,
              decoration: TextDecoration.underline,
              fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                topText(),
                signInRow(Icon(Icons.account_circle), "Username/Email", false,
                    usernameController),
                signInRow(
                    Icon(Icons.vpn_key), "Password", true, passwordController),
                signInButton(),
                orContainer(50),
                seperateServicesSignInColumn(),
                signUpButton(context),
                skip(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
