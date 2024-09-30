import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_film_screening.dart/get_all_film_screening_events.dart';
import 'package:front_end_gestion_cinema/controller/get_all_film_screening.dart/get_all_film_screening_states.dart';
import 'package:front_end_gestion_cinema/data/models/filmScreening.dart';
import 'package:front_end_gestion_cinema/data/models/room.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_all_filmSreening_repository.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_all_rooms_repository.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_category.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_film_repository.dart';
import 'package:front_end_gestion_cinema/data/repositories/get_sessionFilmScreening_repository.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetAllFilmScreeningBloc
    extends Bloc<GetFilmScreeningEvent, GetFilmScreeningState> {
  GetAllFilmScreeningBloc() : super(LoadingGetilmScreeningState()) {
    on<GetAllFilmScreenngEvent>((event, emit) async {
      emit(LoadingGetilmScreeningState());
      
      GetAllRoomsRepository getAllRoomsRepository = GetAllRoomsRepository(
          getAllRoomsService: GetService(url: event.urlRooms));
      await getAllRoomsRepository.runService();
      List<Room> listRooms = [];
      List<FilmScreening> listFilmscreening = [];
      GetAllFilmsreeningRepository getAllFilmsreeningRepository;
      GetFilmRepository getFilmRepository;
      GetSessionfilmscreeningRepository getSessionfilmscreeningRepository;
      GetCategory getCategory;
      bool boucleRoomsHaveError = false;
      bool boucleFilmsScreeningHaveError = false;
      bool boucleFilmHaveError = false;
      bool boucleCategoryHaveError = false;
      bool boucleSessionfilmscreeningHaveError = false;
      if (!getAllRoomsRepository.haveError) {
        listRooms = getAllRoomsRepository.rooms;
        for (var room in listRooms) {
          getAllFilmsreeningRepository = GetAllFilmsreeningRepository(
              getAllFilmscreeningService:
                  GetService(url: room.urlFilmScreenings));
          await getAllFilmsreeningRepository.runService();
          if (!getAllFilmsreeningRepository.haveError) {
            for (var filmscreening
                in getAllFilmsreeningRepository.filmscreenings) {
              filmscreening.room = room;
              getFilmRepository = GetFilmRepository(
                  getFilmService: GetService(url: filmscreening.urlFilm));
              await getFilmRepository.runService();
              if (!getFilmRepository.haveError) {
                filmscreening.film = getFilmRepository.film;
                getCategory = GetCategory(
                    getCategory:
                        GetService(url: filmscreening.film.urlCategory));
                await getCategory.runService();
                if (!getCategory.haveError) {
                  filmscreening.film.category = getCategory.category;
                  //njib session te3 film screening
                  getSessionfilmscreeningRepository =
                      GetSessionfilmscreeningRepository(
                          getSessionFilmScreeningService: GetService(
                              url: filmscreening.urlSessionFilmScreening));
                  await getSessionfilmscreeningRepository.runService();
                  if (!getSessionfilmscreeningRepository.haveError) {
                    filmscreening.sessionFilmScreening =
                        getSessionfilmscreeningRepository.sessionFilmScreening;
                    listFilmscreening.add(filmscreening);
                  } else {
                    boucleSessionfilmscreeningHaveError = true;
                  }
                } else {
                  boucleCategoryHaveError = true;
                }
              } else {
                boucleFilmHaveError = true;
              }
            }
          } else {
            boucleFilmsScreeningHaveError = true;
          }
        }
      } else {
        boucleRoomsHaveError = true;
      }

      if (boucleRoomsHaveError ||
          boucleFilmsScreeningHaveError ||
          boucleFilmHaveError ||
          boucleCategoryHaveError ||
          boucleSessionfilmscreeningHaveError) {
        emit(FailledGetFilmScreeningState("error to get films screening"));
      } else {
        emit(SuccessGetilmScreeningState(MyFilmscreenings: listFilmscreening));
      }
    });
  }
}
