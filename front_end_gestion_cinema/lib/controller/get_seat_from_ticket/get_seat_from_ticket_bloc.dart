import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_seat_from_ticket/get_seat_from_ticket_events.dart';
import 'package:front_end_gestion_cinema/controller/get_seat_from_ticket/get_seat_from_ticket_states.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_seat_repository.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetSeatFromTicketBloc
    extends Bloc<GetSeatFromTicketEvents, GetSeatFromTicketStates> {
  GetSeatFromTicketBloc() : super(LoadingGetSeatFromTicketStates()) {
    on<GetSeatFromTicketEvent>((event, emit) async {
      emit(LoadingGetSeatFromTicketStates());
      GetSeatRepository getSeatRepository =
          GetSeatRepository(getSeatService: GetService(url: event.urlSeat));
      await getSeatRepository.runService();
      if (!getSeatRepository.haveError) {
        emit(SuccessGetSeatFromTicketStates(seat: getSeatRepository.seat));
      } else {
        emit(FailledGetSeatFromTicketStates(errorMessage: 'error to get seat'));
      }
    });
  }
}
