import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

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

  Widget signUpButton() {
    return Container(
      padding: EdgeInsets.only(left: 22),
      child: ElevatedButton(
        onPressed: null,
        child: Text("Sign up", style: TextStyle(color: Colors.black)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            minimumSize: MaterialStateProperty.all<Size>(Size(335, 50))),
      ),
    );
  }

  Widget seperateServicesSignInColumn() {
    //bool isApple = isAppleDevice();
    double height = 60;
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
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                topText(),
                signUpRow(Icon(Icons.email), "Email", false, emailController),
                signUpRow(Icon(Icons.account_circle_outlined), "Username",
                    false, usernameController),
                signUpRow(
                    Icon(Icons.vpn_key), "Password", true, passwordController),
                signUpRow(Icon(Icons.vpn_lock), "Password Confirmation", true,
                    passwordConfirmationController),
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
