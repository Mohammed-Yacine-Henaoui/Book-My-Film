import 'package:front_end_gestion_cinema/data/models/cinema.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetAllCinemasRepository {
  final GetService getAllCinemasService;
  bool haveAError=true;
  List<Cinema> cinemas = [];

  GetAllCinemasRepository({required this.getAllCinemasService});

  Future<void> runService() async {
    await getAllCinemasService.runHttp();
    if (!getAllCinemasService.haveError) {
      haveAError = false;
      Map<String,dynamic> CinemasMap = getAllCinemasService.response;
      CinemasMap["_embedded"]["cinemas"].forEach((cinema) {
        cinemas.add(Cinema.fromJson(cinema));
      });
    } 
  }
}
