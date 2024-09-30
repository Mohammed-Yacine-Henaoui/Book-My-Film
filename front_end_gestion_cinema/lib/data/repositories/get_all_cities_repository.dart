import 'package:front_end_gestion_cinema/data/models/city.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetAllCitiesRepository {
  final GetService getAllCitiesService;
  bool haveAError = true;
  List<City> cities = [];

  GetAllCitiesRepository({required this.getAllCitiesService});

  Future<void> runService() async {
    await getAllCitiesService.runHttp();
    if (!getAllCitiesService.haveError) {
      haveAError = false;
      Map<String, dynamic> CitiesMap = getAllCitiesService.response;
      CitiesMap["_embedded"]["cities"].forEach((city){
        cities.add(City.fromJson(city));
      });
    }
  }
}
