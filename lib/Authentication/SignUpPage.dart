import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;

  String errorMessage = "";

  @override
  initState() {
    emailController = new TextEditingController();
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
    passwordConfirmationController = new TextEditingController();

    super.initState();
  }

  //Check if email is valid
  String? emailValidator(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Email is not valid";
    } else {
      return null;
    }
  }

  //Check if username is already in database
  String? usernameValidator(String value) {
    return null;
  }

  //Check if password fits requirements
  String? passwordValidator(String value) {
    return null;
  }

  bool isAppleDevice() {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
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

  Widget signUpRow(Icon icon, String inputText, bool secureText,
      TextEditingController controller, String? validator) {
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
          child: TextFormField(
            obscureText: secureText,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: inputText,
            ),
            validator: (value) => validator,
          ),
        ),
      ],
    );
  }

  Widget signUpButton() {
    return Container(
      padding: EdgeInsets.only(left: 22),
      child: ElevatedButton(
        onPressed: () => signUp(),
        child: Text("Sign up", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            minimumSize: MaterialStateProperty.all<Size>(Size(335, 50))),
      ),
    );
  }

  Future signUp() async {
    if (passwordConfirmationController.text.toString() !=
        passwordController.text.toString()) {
      //Implement incorrect password match
      errorMessage = "Passwords do not match";
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ); //Implement then and firestore research
    } on FirebaseAuthException catch (e) {
      //During submission, might want to adjust to change validators if possible
      if (e.code == 'weak-password') {
        errorMessage = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email";
      }
    } catch (e) {
      print(e);
    }
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

  Widget signInButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, bottom: 5),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(
            context, MaterialPageRoute(builder: (context) => SignUpPage())),
        child: Text("Sign in", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
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
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                topText(),
                signUpRow(Icon(Icons.email), "Email", false, emailController,
                    emailValidator(emailController.text.toString())),
                signUpRow(
                    Icon(Icons.account_circle_outlined),
                    "Username",
                    false,
                    usernameController,
                    usernameValidator(usernameController.text.toString())),
                signUpRow(
                    Icon(Icons.vpn_key),
                    "Password",
                    true,
                    passwordController,
                    passwordValidator(passwordController.text.toString())),
                signUpRow(
                    Icon(Icons.vpn_lock),
                    "Password Confirmation",
                    true,
                    passwordConfirmationController,
                    passwordValidator(
                        passwordConfirmationController.text.toString())),
                signUpButton(),
                orContainer(50),
                seperateServicesSignInColumn(),
                signInButton(context),
                skip(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
