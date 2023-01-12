import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      webPosition: 'center',
      textColor: Colors.black,
      webBgColor: 'white',
      backgroundColor: Colors.white);
}

void showDarkToast({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.SNACKBAR,
      webPosition: 'center',
      textColor: Colors.white,
      webBgColor: '#000000bf',
      backgroundColor: Colors.black.withOpacity(0.75));
}