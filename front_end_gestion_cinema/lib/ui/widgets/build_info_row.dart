import 'package:flutter/material.dart';

Widget BuildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Expanded(
          flex: 2,
          child: Text(
            label + " :",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      
        Expanded(
          flex: 3,
          child: Text(
            value,
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}
