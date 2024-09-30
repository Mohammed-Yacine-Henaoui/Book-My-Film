import 'package:front_end_gestion_cinema/data/models/filmScreening.dart';

class GetFilmScreeningState {}

class SuccessGetilmScreeningState extends GetFilmScreeningState {
  final List<FilmScreening> MyFilmscreenings;

  SuccessGetilmScreeningState({required this.MyFilmscreenings});
}

class FailledGetFilmScreeningState extends GetFilmScreeningState {
  String errorMessage;
  FailledGetFilmScreeningState(this.errorMessage);
}

class LoadingGetilmScreeningState extends GetFilmScreeningState {}
