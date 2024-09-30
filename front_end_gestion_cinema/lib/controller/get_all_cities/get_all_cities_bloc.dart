import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_gestion_cinema/contants/http_urls.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cities/get_all_cities_events.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cities/get_all_cities_states.dart';
import 'package:front_end_gestion_cinema/data/models/city.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_all_cities_repository.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetAllCitiesBloc extends Bloc<GetAllCitiesEvent, GetAllCitiesState> {
  GetAllCitiesBloc() : super(InitialGetAllCitiesState()) {
    on<GetAllCitiesEvent>((event, emit) async {
      emit(LoadingGetAllCitiesState());
      GetAllCitiesRepository getAllCitiesRepository =
      GetAllCitiesRepository(getAllCitiesService: GetService(url:HttpUrls.baseUrl+HttpUrls.getAllCities));
      await getAllCitiesRepository.runService();
      bool error = getAllCitiesRepository.haveAError;
      if (!error) {
        List<City> cities = getAllCitiesRepository.cities;
        emit(SuccessGetAllCitiesState(cities: cities));
      } else {
        emit(FailledGetAllCitiesState(errorMessage: "failled to get all cities."));
      }
    });
  }
}
