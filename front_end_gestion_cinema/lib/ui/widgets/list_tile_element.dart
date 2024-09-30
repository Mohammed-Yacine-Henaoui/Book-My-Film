import 'package:flutter/material.dart';

Widget ListTileElement(String title,IconData? iconLeading,Function()? onTapFunction){
  return ListTile(
    splashColor: Colors.orange[100],
    title: Text(title),
    leading: Icon(iconLeading),
    trailing: const Icon(Icons.arrow_right),
    onTap: onTapFunction,
  );
}
