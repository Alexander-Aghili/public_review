import 'package:flutter/material.dart';

class CompleteSignUpOfCustomUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CompleteSignUpOfCustomUser();
}

class _CompleteSignUpOfCustomUser extends State<CompleteSignUpOfCustomUser> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Widget infoForm() {
    return Form(
      key: registerFormKey,
      child: Column(
        children: <Widget>[
          
        ],
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
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }
}
