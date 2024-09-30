import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:front_end_gestion_cinema/contants/http_urls.dart';
import 'package:front_end_gestion_cinema/controller/get_all_film_screening.dart/get_all_film_screening_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_film_screening.dart/get_all_film_screening_events.dart';
import 'package:front_end_gestion_cinema/controller/get_all_film_screening.dart/get_all_film_screening_states.dart';
import 'package:front_end_gestion_cinema/controller/get_tickets/get_tickets_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_tickets/get_tickets_events.dart';
import 'package:front_end_gestion_cinema/data/models/cinema.dart';
import 'package:front_end_gestion_cinema/data/models/filmScreening.dart';
import 'package:front_end_gestion_cinema/functions/error_dialog.dart';
import 'package:front_end_gestion_cinema/ui/screens/film_screening_details.dart';
import 'package:front_end_gestion_cinema/ui/widgets/build_divider.dart';
import 'package:front_end_gestion_cinema/ui/widgets/build_info_row.dart';
import 'package:front_end_gestion_cinema/ui/widgets/failled_get_all_cities_state_widget.dart';
import 'package:front_end_gestion_cinema/ui/widgets/loading_get_all_cities_state_widget.dart';

class FilmsScreening extends StatelessWidget {
  final Cinema cinema;

  const FilmsScreening({super.key, required this.cinema});

  @override
  Widget build(BuildContext context) {
    String animationLoading = "loading_cinemas.gif";
    String animationLoadingImage = 'images/loadingImage.gif';
    FilmScreening filmScreening;
    FilmScreening filmScreening1 = FilmScreening();
    return Scaffold(
        appBar: AppBar(
          title: Text(cinema.name + " Cinema"),
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<GetAllFilmScreeningBloc, GetFilmScreeningState>(
          builder: (context, state) {
            if (state is LoadingGetilmScreeningState) {
              return LoadingGetAllCitiesStateWidget(animationLoading);
            } else if (state is FailledGetFilmScreeningState) {
              ErrorDialog(context, state.errorMessage);
              return FailledGetAllCitiesStateWidget(
                context,
                () {
                  context
                      .read<GetAllFilmScreeningBloc>()
                      .add(GetAllFilmScreenngEvent(urlRooms: cinema.urlRooms));
                },
              );
            } else if (state is SuccessGetilmScreeningState) {
              return Center(
                  child: CardSwiper(
                cardsCount: state.MyFilmscreenings.length,
                cardBuilder: (BuildContext context,
                    int index,
                    int horizontalOffsetPercentage,
                    int verticalOffsetPercentage) {
                  if (index != 0) {
                    filmScreening1 = state.MyFilmscreenings[index - 1];
                  }
                  filmScreening = state.MyFilmscreenings[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<GetTicketsBloc>().add(
                          GetTicketsOfFilmScreeningEvent(
                              urlTickets: filmScreening.urlTickets));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FilmScreeningDetails(
                                    filmScreening: filmScreening1,
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      //color: Theme.of(context).canvasColor,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: animationLoadingImage,
                            image: HttpUrls.baseUrl +
                                '/imageFilm/' +
                                filmScreening.film.image,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            filmScreening.film.title,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          BuildInfoRow(
                              "Category", filmScreening.film.category.name),
                          BuildDivider(235, context),
                          BuildInfoRow("Start date", filmScreening.startDate),
                          BuildDivider(228, context),
                          BuildInfoRow(
                              "Time", filmScreening.sessionFilmScreening.time),
                          BuildDivider(260, context),
                          BuildInfoRow("Duration", filmScreening.film.duration),
                          BuildDivider(237, context),
                          BuildInfoRow(
                              "Price", filmScreening.price.toString() + " DA"),
                          BuildDivider(258, context),
                        ],
                      ),
                    ),
                  );
                },
              ));
            }
            return Container();
          },
        ));
  }
}
