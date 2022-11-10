import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showErrorToast({String? msg}) {
  Fluttertoast.showToast(
      msg: msg ?? "Error occured",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      textColor: Colors.white,
      fontSize: 16.0);
}
