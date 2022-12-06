import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static toastView({required msg}) {
    var LENGTH_SHORT;
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 255, 255, 255) ,
        textColor: Color.fromRGBO(82, 21, 72, 1),
        fontSize: 16.0);
  }
}
