import 'package:front_end_gestion_cinema/data/models/city.dart';

abstract class GetAllCitiesState {}

class SuccessGetAllCitiesState extends GetAllCitiesState{
  final List<City> cities;
  SuccessGetAllCitiesState({required this.cities});
}

class FailledGetAllCitiesState extends GetAllCitiesState{
  final String errorMessage;
  FailledGetAllCitiesState({required this.errorMessage});
}

class LoadingGetAllCitiesState extends GetAllCitiesState{}

class InitialGetAllCitiesState extends GetAllCitiesState{}

