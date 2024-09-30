import 'package:front_end_gestion_cinema/data/models/cinema.dart';

abstract class GetAllCinemasState {}

class SuccessGetAllCinemasState extends GetAllCinemasState {
  final List<Cinema> cinemas;
  SuccessGetAllCinemasState({required this.cinemas});
}

class FailledGetAllCinemasState extends GetAllCinemasState {
  final String errorMessage;
  FailledGetAllCinemasState({required this.errorMessage});
}

class LoadingGetAllCinemasState extends GetAllCinemasState {}

class InitialGetAllCinemasState extends GetAllCinemasState {}
