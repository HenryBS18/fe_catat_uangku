import 'package:flutter/material.dart';

class Util {
  static SnackBar getSnackBar(BuildContext context, String message) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
  }
}