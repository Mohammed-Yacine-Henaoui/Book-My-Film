import 'package:front_end_gestion_cinema/data/models/ticket.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetAllTicketsRepository {
  final GetService getAllTicketsService;
  bool haveAError = true;
  List<Ticket> tickets = [];
  
  GetAllTicketsRepository({required this.getAllTicketsService});

  Future<void> runService() async {
    await getAllTicketsService.runHttp();
    if (!getAllTicketsService.haveError) {
      haveAError = false;
      Map<String, dynamic> ticketsMap = getAllTicketsService.response;
      ticketsMap["_embedded"]["tickets"].forEach((ticket) {
        tickets.add(Ticket.fromJson(ticket));
      });
    }
  }
}
