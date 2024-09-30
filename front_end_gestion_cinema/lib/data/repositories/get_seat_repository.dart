import 'package:front_end_gestion_cinema/data/models/seat.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetSeatRepository {
  final GetService getSeatService;
  bool haveError = true;
  Seat seat = Seat();
  GetSeatRepository({required this.getSeatService});
  Future<void> runService() async {
    await getSeatService.runHttp();
    if (!getSeatService.haveError) {  
      haveError = false;
      Map<String, dynamic> seatMap = getSeatService.response;
      seat = Seat.fromJson(seatMap);
    }
  }
}
