import 'package:flutter/material.dart';

dynamic MySnackbar(BuildContext context,Color? color,String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
    ),
  );
}
