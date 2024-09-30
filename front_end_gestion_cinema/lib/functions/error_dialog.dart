import 'package:flutter/material.dart';

ErrorDialog(BuildContext context,String errorMessage){
  WidgetsBinding.instance.addPostFrameCallback((_) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Error",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            errorMessage,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Fermer l'AlertDialog
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.red[700],
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              "OK",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
});
}