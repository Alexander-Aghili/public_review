import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:public_review/AppOverview/HomePage.dart';
import 'package:public_review/Authentication/CustomAuth.dart';
import 'package:public_review/Authentication/SignUpPage.dart';

import 'VerifyEmailPage.dart';

//To Implement:
//Forget Password
//Help
//Third Party

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  String emailMessage = "";
  String passwordMessage = "";

  @override
  initState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    super.initState();
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isAppleDevice() {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  Widget topText() {
    return Text(
      "Public Review",
      style:
          TextStyle(fontSize: 55.0, color: Colors.black, fontFamily: "Dosis"),
    );
  }

  String? emailValidator(String? value) {
    if (emailMessage == "no user") {
      return "No email can be found";
    } else if (emailMessage == "bad input") {
      return "Invalid email input";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (passwordMessage == "incorrect input") {
      return "Incorrect Password";
    }
    return null;
  }

  Widget signInForm() {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: <Widget>[
          signInRow(Icon(Icons.account_circle), "Email", false, emailController,
              emailValidator),
          signInRow(Icon(Icons.vpn_key), "Password", true, passwordController,
              passwordValidator),
        ],
      ),
    );
  }

  Widget signInRow(Icon icon, String inputText, bool secureText,
      TextEditingController controller, Function validator) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
          child: TextFormField(
            obscureText: secureText,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: inputText,
            ),
            validator: (value) => validator(value),
          ),
        ),
      ],
    );
  }

  Widget signInButton() {
    return Container(
      child: ElevatedButton(
        onPressed: () => signIn(),
        child: Text("Sign in", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            minimumSize: MaterialStateProperty.all<Size>(Size(300, 50))),
      ),
    );
  }

  //Login wont work until reload, CustomAuth Sign in doesn't return Success but instance of Future String
  Future signIn() async {
    emailMessage = "";
    passwordMessage = "";

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString());

      User user = FirebaseAuth.instance.currentUser!;
      user.reload();

      if (user.emailVerified) {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => new HomePage()));
      } else {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    VerifyEmailPage(email: emailController.text.toString())));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emailMessage = "no user";
        passwordController.clear();
      } else if (e.code == "invalid-email") {
        emailMessage = "bad input";
        passwordController.clear();
      } else if (e.code == 'wrong-password') {
        passwordMessage = "incorrect input";
        passwordController.clear();
      }
      if (_registerFormKey.currentState != null &&
          !_registerFormKey.currentState!.validate()) {
        return;
      }
    } catch (e) {}
  }

  Widget signUpButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, bottom: 5),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage())),
        child: Text("Sign up", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
        ),
      ),
    );
  }

  Widget seperateServicesSignInColumn() {
    bool isApple = isAppleDevice();
    double height = 60;
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
        ],
      );
    }
  }

  Widget signInWithSeperateServiceButton(
      /*VoidCallback action,*/ AssetImage image) {
    return GestureDetector(
      onTap: null,
      child: Container(
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

  Widget help() {
    return GestureDetector(
      onTap: null,
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 100,
        height: 40,
        child: Text(
          "Help",
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
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  topText(),
                  signInForm(),
                  signInButton(),
                  orContainer(50),
                  seperateServicesSignInColumn(),
                  signUpButton(context),
                  help(),
                ],
              ),
            ],
          )),
    );
  }
}
