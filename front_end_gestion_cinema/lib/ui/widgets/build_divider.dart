import 'package:flutter/material.dart';

Divider BuildDivider(double endIndent,BuildContext context) {
  return Divider(
    color: Theme.of(context).primaryColor,
    endIndent: endIndent,
    thickness: 2,
  );
}