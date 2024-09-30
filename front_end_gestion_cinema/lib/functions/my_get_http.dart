import 'dart:convert';

import 'package:front_end_gestion_cinema/contants/error_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<dynamic> MyGetHttp(String url) async {
  try{
  Uri toUri = Uri.parse(url);
  Response response = await http.get(toUri)
  .timeout(const Duration(seconds: 30));
  if (response.statusCode == 200) {
    String json = response.body;
    return jsonDecode(json);
  } else {
    return errorResponse;
  }
  }
  catch(e){
    return errorResponse;
  }
}
