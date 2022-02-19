import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, required String titleText}) {
  return AppBar(
    title: Text(
      isAppTitle ? "PROFILE" : titleText,
      style: TextStyle(color: Colors.white, fontSize: isAppTitle ? 25.0 : 20.0),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
  );
}
