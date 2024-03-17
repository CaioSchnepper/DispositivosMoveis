import 'package:flutter/material.dart';

class SnackBarHelper {
  static void show(BuildContext context, String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
