import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar(String message, {Key? key})
      : super(
          key: key,
          content: Text(message),
          backgroundColor: Colors.red,
        );
}

class SuccessSnackBar extends SnackBar {
  SuccessSnackBar(String message, {Key? key})
      : super(
          key: key,
          content: Text(message),
          backgroundColor: Colors.green,
        );
}
