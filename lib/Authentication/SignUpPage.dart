import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  late _SignUpInfo signUpInfo;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;

  String errorMessage = "";
  String usernameErrorMessage = "";

  @override
  initState() {
    emailController = new TextEditingController();
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
    passwordConfirmationController = new TextEditingController();

    signUpInfo = new _SignUpInfo(
      registerFormKey: _registerFormKey,
      usernameController: usernameController,
      passwordConfirmationController: passwordConfirmationController,
      passwordController: passwordController,
      errorMessage: errorMessage,
      usernameErrorMessage: usernameErrorMessage);
    super.initState();
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

  Widget signUpForm() {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          signUpRow(Icon(Icons.email), "Email", false, emailController,
              signUpInfo.emailValidator),
          signUpRow(Icon(Icons.account_circle_outlined), "Username", false,
              usernameController, signUpInfo.usernameValidator),
          signUpRow(Icon(Icons.vpn_key), "Password", true, passwordController,
              signUpInfo.passwordValidator),
          signUpRow(Icon(Icons.vpn_lock), "Password Confirmation", true,
              passwordConfirmationController, signUpInfo.passwordValidator),
        ],
      ),
    );
  }

  Widget signUpRow(Icon icon, String inputText, bool secureText,
      TextEditingController controller, Function validator) {
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
            validator: (value) => validator(value),
          ),
        ),
      ],
    );
  }

  Widget signUpButton() {
    return Container(
      padding: EdgeInsets.only(left: 22),
      child: ElevatedButton(
        onPressed: () => signUpInfo,
        child: Text("Sign up", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            minimumSize: MaterialStateProperty.all<Size>(Size(335, 50))),
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
                signUpForm(),
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

class _SignUpInfo {
  GlobalKey<FormState> registerFormKey;
  TextEditingController usernameController;
  TextEditingController passwordConfirmationController;
  TextEditingController passwordController;

  String errorMessage;
  String usernameErrorMessage;

  _SignUpInfo({
    required this.registerFormKey,
    required this.usernameController,
    required this.passwordConfirmationController,
    required this.passwordController,
    required this.errorMessage,
    required this.usernameErrorMessage,
  });

  Future signUp() async {
    //Figure out how to do password stuff
    if (passwordConfirmationController.text.toString() !=
        passwordController.text.toString()) {
      errorMessage = "Passwords do not match";
      return;
    }

    String username = usernameController.text.toString();

    bool validUsername = await usernameIsInDatabase(username);
    if (!validUsername && !_usernameCheck(username)) {}

    if (registerFormKey.currentState != null &&
        !registerFormKey.currentState!.validate()) {
      return;
    }

    try {
      /*UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );*/ //Implement then and firestore research
    } on FirebaseAuthException catch (e) {
      //During submission, might want to adjust to change validators if possible
      errorMessage = e.code;
    } catch (e) {
      print(e);
    }
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

  bool _usernameCheck(String username) {
    if (username.length < 4) {
      usernameErrorMessage = "too short";
      return false;
    } else if (username.length > 20) {
      usernameErrorMessage = "too long";
      return false;
    // ignore: dead_code
    } else if (/*username contains a slur on slur list*/ false) {
      usernameErrorMessage = "bad username";
      return false;
    }
    return true;
  }

  Future<bool> usernameIsInDatabase(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return result.docs.isEmpty;
  }

  String? usernameValidator(String? value) {
    if (usernameErrorMessage == "user exists") {
      return "This username already exists, select a different one.";
    } else if (usernameErrorMessage == "too short") {
      return "The username is too short";
    } else if (usernameErrorMessage == "too long") {
      return "The username is too long";
    } else if (usernameErrorMessage == "bad username") {
      return "Invalud username";
    } else {
      return null;
    }
  }

  //Check if password fits requirements
  String? passwordValidator(String value) {
    if (errorMessage == 'weak-password') {
      return "The password provided is too weak";
    } else if (errorMessage == 'email-already-in-use') {
      return "The account already exists for that email";
    } else if (errorMessage == "Passwords do not match") {
      return "Password does not match";
    } else {
      return null;
    }
  }
}
