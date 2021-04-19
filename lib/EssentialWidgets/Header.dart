import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle=false, String? title, eliminateBackButton = false}){
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    automaticallyImplyLeading: eliminateBackButton ? false: true,
    title: Text(
      (isAppTitle ? "Public Review" : title)!,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Dosis",
        fontSize: 35.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}