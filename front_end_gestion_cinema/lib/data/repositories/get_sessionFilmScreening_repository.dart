import 'package:front_end_gestion_cinema/data/models/session_film_screening.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetSessionfilmscreeningRepository {
  final GetService getSessionFilmScreeningService;
  late bool haveError = true;
  SessionFilmScreening sessionFilmScreening = SessionFilmScreening();


  GetSessionfilmscreeningRepository({required this.getSessionFilmScreeningService});

  Future<dynamic> runService() async {
    await getSessionFilmScreeningService.runHttp();
    if (!getSessionFilmScreeningService.haveError) {
      haveError = false;
      sessionFilmScreening = SessionFilmScreening.fromJson(getSessionFilmScreeningService.response);
    }
  }
}
