import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast({
  required String msg,
  bool isError = false,
}) async {
  return await Fluttertoast.showToast(
    msg: msg,
    backgroundColor: isError ? Colors.red : Colors.green,
  );
}
