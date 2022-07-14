import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin FlushBarMixin {
  void showSuccessNotification(BuildContext context, String message) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.green[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.green[300],
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  void showSuccessNotificationWithTime(
      BuildContext context, String message, int timeInSeconds) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.green[300],
      ),
      duration: Duration(seconds: timeInSeconds),
      leftBarIndicatorColor: Colors.green[300],
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  void showErrorNotification(BuildContext context, String message) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.red[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red[300],
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  void showErrorNotificationWithTime(
      BuildContext context, String message, int timeInSeconds) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.red[300],
      ),
      duration: Duration(seconds: timeInSeconds),
      leftBarIndicatorColor: Colors.red[300],
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }
}
