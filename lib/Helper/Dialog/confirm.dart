import 'package:flutter/material.dart';
import 'package:flutter_crud_basic/Helper/Dialog/dialog.dart';

class ConfirmHelper {
  static Future confirmDelete (
    BuildContext context, {
    VoidCallback? callback,
    }
  ){
    return confirm(
      context,
      message: "Are you sure you want to delete this?",
      buttonTitle: "Delete",
      colorButton: Colors.red,
      callback: callback ?? () => Navigator.pop(context),
    );
  }

  static Future confirm(
    BuildContext context, {
    required String message,
    required String buttonTitle,
    required Color colorButton,
    VoidCallback? callback,
    }
  ) {
    return DialogHelper.dialogTemplate(
      context,
      message: message,
      buttonTitle: buttonTitle,
      colorButton: colorButton,
      callback: callback ?? () => Navigator.pop(context),
      confirm: true,
    );
  }
}