import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "Authentication/AuthPage.dart";

//Main Issues:
//-Listview for sign in page is awkward, possible fix(Put scrollorientation as horizontal)
//-Screen can have landscape mode, prevent it.
//-Custom Auth
//-Google Auth
//-Facebook Auth
//-Twitter Auth
//-Apple Auth

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Not implemented for iOS use yet, implement at a later date
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      title: 'Public Reveiew',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black54,
        dialogBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        accentColor: const Color(0xFFC8E6C9),
        cardColor: Colors.white70,
      ),
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
