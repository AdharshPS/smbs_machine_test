import 'package:flutter/material.dart';

void showSnackBar({
  required ScaffoldMessengerState scaffoldMessenger,
  required String content,
  required Color backgroundColor,
}) {
  scaffoldMessenger.showSnackBar(
    SnackBar(content: Text(content), backgroundColor: backgroundColor),
  );
}
