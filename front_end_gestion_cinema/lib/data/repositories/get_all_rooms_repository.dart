import 'package:front_end_gestion_cinema/data/models/room.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetAllRoomsRepository {
  final GetService getAllRoomsService;
  List<Room> rooms = [];
  bool haveError = false;

  GetAllRoomsRepository({required this.getAllRoomsService});

  Future<void> runService() async {
    await getAllRoomsService.runHttp();
    if (!getAllRoomsService.haveError) {
      haveError = false;
      Map<String, dynamic> RoomsMap = getAllRoomsService.response;
      RoomsMap["_embedded"]["rooms"].forEach((room) {
        rooms.add(Room.fromJson(room));
      });
    }
  }
}
