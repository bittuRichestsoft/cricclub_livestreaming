import 'package:cricclub_livestreaming/main.dart';
import 'package:flutter/material.dart';

var context = navigatorKey.currentContext!;
void showSnackBar(String msg) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: Duration(seconds: 1),
  ));
}
