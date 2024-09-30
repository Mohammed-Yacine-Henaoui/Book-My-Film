class SessionFilmScreening {
  late String time;


  SessionFilmScreening() {}

  SessionFilmScreening.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }
}
