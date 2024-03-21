import 'package:flutter/material.dart';

class SnackBarHelper {
  static void show(BuildContext context, String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
          label: 'OK',
          onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
