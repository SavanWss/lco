import 'package:flutter/material.dart';

class CircularIndicator {
  static startCircularIndicator(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static stopCircularIndicator(BuildContext context) {
    Navigator.of(context).pop();
  }
}