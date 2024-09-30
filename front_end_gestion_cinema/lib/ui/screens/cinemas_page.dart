import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cinemas/get_all_cinemas_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cinemas/get_all_cinemas_events.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cinemas/get_all_cinemas_states.dart';
import 'package:front_end_gestion_cinema/controller/get_all_film_screening.dart/get_all_film_screening_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_film_screening.dart/get_all_film_screening_events.dart';
import 'package:front_end_gestion_cinema/data/models/city.dart';
import 'package:front_end_gestion_cinema/functions/error_dialog.dart';
import 'package:front_end_gestion_cinema/ui/screens/films_screening.dart';
import 'package:front_end_gestion_cinema/ui/widgets/failled_get_all_cities_state_widget.dart';
import 'package:front_end_gestion_cinema/ui/widgets/loading_get_all_cities_state_widget.dart';

class CinemasPage extends StatelessWidget {
  final City city;

  const CinemasPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    String animationLoading = "loading_cinemas.gif";
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name + " City"),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<GetAllCinemasBloc, GetAllCinemasState>(
          builder: (context, state) {
        if (state is LoadingGetAllCinemasState) {
          return LoadingGetAllCitiesStateWidget(animationLoading);
        } else if (state is FailledGetAllCinemasState) {
          ErrorDialog(context, state.errorMessage);
          return FailledGetAllCitiesStateWidget(
            context,
            () {
              context
                  .read<GetAllCinemasBloc>()
                  .add(GetAllCinemasEvent(url: city.urlCinemas));
            },
          );
        } else if (state is SuccessGetAllCinemasState) {
          return Center(
            child: CardSwiper(
              cardsCount: state.cinemas.length,
              cardBuilder: (BuildContext context,
                  int index,
                  int horizontalOffsetPercentage,
                  int verticalOffsetPercentage) {
                return GestureDetector(
                    onTap: () {
                      context.read<GetAllFilmScreeningBloc>().add(
                          GetAllFilmScreenngEvent(
                              urlRooms: state.cinemas[index].urlRooms));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FilmsScreening(cinema: state.cinemas[index]),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.cinemas[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20),
                          ),
                          Image.asset(
                              "images/" + state.cinemas[index].name + ".jpg"),
                        ],
                      ),
                    ) // Add your widget here
                    );
              },
            ),
          );
        }
        return Container();
      }),
    );
  }
}
