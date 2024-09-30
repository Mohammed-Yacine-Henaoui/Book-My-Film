import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end_gestion_cinema/functions/snackbar.dart';
import 'package:http/http.dart';

Future<void> MyPatchHttp(String url, Map<String, dynamic> data,BuildContext context,String messageSuccess,String messageFailled) async {
  final Response response = await patch(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 204) {
    MySnackbar(context,Colors.greenAccent,messageSuccess);
  }
  else{
    MySnackbar(context,Colors.redAccent,messageFailled);
  }
}
