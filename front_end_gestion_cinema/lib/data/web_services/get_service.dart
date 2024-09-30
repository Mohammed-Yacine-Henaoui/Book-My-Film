import 'package:front_end_gestion_cinema/contants/error_response.dart';
import 'package:front_end_gestion_cinema/functions/my_get_http.dart';

class GetService {
  bool haveError=true;
  Map<String, dynamic> response={};
  final String url;

  GetService({required this.url});

  Future<void> runHttp() async {
    var responseHttp = await MyGetHttp(url);
    if (responseHttp != errorResponse) {
      haveError = false;
      response = responseHttp;
    }
  }
}
