import 'package:befit_v2/utils/constants.dart';
import 'package:flutter/material.dart';

class UIComponents {
  static void showSnackBar(BuildContext context, String text, Duration d) {
    ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(backgroundColor: Colors.white, content: Text(text,style: const TextStyle(color: Colors.black, fontSize: 15)),behavior: SnackBarBehavior.floating, duration: d,));
  }

  static void showLoading(BuildContext context) {
    ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(const SnackBar(backgroundColor: appUIPrimaryColor, content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: Colors.white),
      ],
    ), behavior: SnackBarBehavior.floating, duration: Duration(days: 1),));
  }

  static void removeSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}