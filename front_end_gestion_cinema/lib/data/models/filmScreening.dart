import 'package:front_end_gestion_cinema/data/models/film.dart';
import 'package:front_end_gestion_cinema/data/models/room.dart';
import 'package:front_end_gestion_cinema/data/models/session_film_screening.dart';

class FilmScreening {
  late String startDate;
  late int price;
  late String urlFilm;
  late String urlTickets;
  late String urlSessionFilmScreening;
  Room room = Room();
  Film film = Film();
  SessionFilmScreening sessionFilmScreening = SessionFilmScreening();

  FilmScreening(){}

  FilmScreening.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    price = json['price'];
    urlFilm = json['_links']['film']['href'];
    urlTickets = json['_links']['tickets']['href'];
    urlSessionFilmScreening = json['_links']['sessionFilmScreening']['href'];
  }
}
