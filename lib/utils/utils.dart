import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastMessege(String messege) {
    Fluttertoast.showToast(
        msg: messege,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
