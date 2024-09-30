import 'package:front_end_gestion_cinema/data/models/filmScreening.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetAllFilmsreeningRepository {
   final GetService getAllFilmscreeningService;
  List<FilmScreening> filmscreenings = [];
  bool haveError = true;

  GetAllFilmsreeningRepository({required this.getAllFilmscreeningService});

  Future<void> runService() async {
    await getAllFilmscreeningService.runHttp();
    if (!getAllFilmscreeningService.haveError) {
      //haveError = false;
      Map<String, dynamic> filmscreeningMap = getAllFilmscreeningService.response;
      filmscreeningMap["_embedded"]["filmScreenings"].forEach((filmscreening) {
        filmscreenings.add(FilmScreening.fromJson(filmscreening));
      });
    }
  }
}
