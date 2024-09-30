import 'package:front_end_gestion_cinema/data/models/film.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetFilmRepository {
  final GetService getFilmService;
  bool haveError = true;
  Film film = Film();

  GetFilmRepository({required this.getFilmService});

  Future<void> runService() async {
    await getFilmService.runHttp();
    if (!getFilmService.haveError) {
      haveError = false;
      Map<String, dynamic> filmMap = getFilmService.response;
      film = Film.fromJson(filmMap);
    }
  }
}
