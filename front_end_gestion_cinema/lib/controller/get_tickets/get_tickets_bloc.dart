import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_tickets/get_tickets_events.dart';
import 'package:front_end_gestion_cinema/controller/get_tickets/get_tickets_states.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_all_tickets_repository.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetTicketsBloc extends Bloc<GetTicketsEvents, GetTicketsStates> {
  GetTicketsBloc() : super(LoadingGetTicketsStates()) {
    on<GetTicketsOfFilmScreeningEvent>((event, emit) async {
      emit(LoadingGetTicketsStates());

      GetAllTicketsRepository getAllTicketsRepository = GetAllTicketsRepository(
          getAllTicketsService: GetService(url: event.urlTickets));
      await getAllTicketsRepository.runService();

      if (!getAllTicketsRepository.haveAError) {
        emit(SuccessGetTicketsStates(tickets: getAllTicketsRepository.tickets));
      } else {
        emit(FailledGetTicketsStates(errorMessage: 'error get tickets'));
      }
    });
  }
}
