import 'package:flutter/material.dart';
import 'package:front_end_gestion_cinema/root/my_routes.dart';
import 'package:front_end_gestion_cinema/root/my_theme.dart';

MaterialApp MyRoot() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: MyTheme(),
    initialRoute: "/",
    routes: MyRootes(),
  );
}
