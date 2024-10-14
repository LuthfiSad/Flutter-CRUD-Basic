import 'package:flutter/material.dart';
import 'package:flutter_crud_basic/Helper/Dialog/dialog.dart';

class AlertHelper {
  static Future alertError(
    BuildContext context, {
    required String message,
    VoidCallback? callback,
  }) {
    return alert(
      context,
      title: "Error",
      message: message,
      colorButton: Colors.red,
      callback: callback ?? () => Navigator.pop(context),
    );
  }

  static Future alertErrorDelay(
    BuildContext context, {
    required String message,
    VoidCallback? callback,
  }) {
    return alert(
      context,
      title: "Error",
      message: message,
      colorButton: Colors.red,
      callback: callback ?? () => Navigator.pop(context),
      delay: 5,
    );
  }

  static Future alertSuccess(
    BuildContext context, {
    required String message,
    VoidCallback? callback,
  }) {
    return alert(
      context,
      title: "Success",
      message: message,
      colorButton: Colors.green,
      callback: callback ?? () => Navigator.pop(context),
    );
  }

  static Future alertSuccessDelay(
    BuildContext context, {
    required String message,
    VoidCallback? callback,
  }) {
    return alert(
      context,
      title: "Success",
      message: message,
      colorButton: Colors.green,
      callback: callback ?? () => Navigator.pop(context),
      delay: 5,
    );
  }

  static Future alert(
    BuildContext context, {
    required String title,
    required String message,
    required Color colorButton,
    VoidCallback? callback,
    int? delay,
    }
  ) {
    return DialogHelper.dialogTemplate(
      context,
      message: message,
      title: title,
      buttonTitle: "Done",
      colorButton: colorButton,
      callback: callback ?? () => Navigator.pop(context),
      delay: delay,
    );
  }
}