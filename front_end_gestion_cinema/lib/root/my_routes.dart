import 'package:flutter/material.dart';
import 'package:front_end_gestion_cinema/ui/screens/cities_page.dart';

Map<String, Widget Function(BuildContext)> MyRootes() {
  return {
    "/": (context) => CitiesPage(),
  };
}
