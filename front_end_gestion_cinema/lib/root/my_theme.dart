import 'package:flutter/material.dart';

ThemeData? MyTheme() {
  return ThemeData(
      primaryColor: Colors.orange,
      canvasColor: Colors.orange[300],
      appBarTheme: const AppBarTheme(color: Colors.orange, centerTitle: true));
}
