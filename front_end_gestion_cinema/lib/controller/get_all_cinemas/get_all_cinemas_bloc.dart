import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cinemas/get_all_cinemas_events.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cinemas/get_all_cinemas_states.dart';
import 'package:front_end_gestion_cinema/data/models/cinema.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_all_cinemas_repository.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetAllCinemasBloc extends Bloc<GetCinemasEvent, GetAllCinemasState> {
  GetAllCinemasBloc() : super(InitialGetAllCinemasState()) {
    on<GetAllCinemasEvent>((event, emit) async {
      emit(LoadingGetAllCinemasState());
      GetAllCinemasRepository getAllCinemasRepository = GetAllCinemasRepository(
          getAllCinemasService: GetService(url:event.url));
      await getAllCinemasRepository.runService();
      bool error = getAllCinemasRepository.haveAError;
      if (!error) {
        List<Cinema> cinemas = getAllCinemasRepository.cinemas;
        emit(SuccessGetAllCinemasState(cinemas: cinemas));
      } else {
        emit(FailledGetAllCinemasState(
            errorMessage: "Failed to get cinemas."));
      }
    });
  }
}
