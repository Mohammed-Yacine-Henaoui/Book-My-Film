import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cinemas/get_all_cinemas_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cinemas/get_all_cinemas_events.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cities/get_all_cities_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cities/get_all_cities_events.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cities/get_all_cities_states.dart';
import 'package:front_end_gestion_cinema/functions/error_dialog.dart';
import 'package:front_end_gestion_cinema/ui/screens/cinemas_page.dart';
import 'package:front_end_gestion_cinema/ui/widgets/failled_get_all_cities_state_widget.dart';
import 'package:front_end_gestion_cinema/ui/widgets/loading_get_all_cities_state_widget.dart';

class CitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String animationLoading = "loading_cities.gif";
    context.read<GetAllCitiesBloc>().add(GetAllCitiesEvent());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cities"),
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<GetAllCitiesBloc, GetAllCitiesState>(
            builder: (context, state) {
          if (state is LoadingGetAllCitiesState) {
            return LoadingGetAllCitiesStateWidget(animationLoading);
          } else if (state is FailledGetAllCitiesState) {
            ErrorDialog(context, state.errorMessage);
            return FailledGetAllCitiesStateWidget(
              context,
              () {
                context.read<GetAllCitiesBloc>().add(GetAllCitiesEvent());
              },
            );
          } else if (state is SuccessGetAllCitiesState) {
            return Center(
              child: CardSwiper(
                cardsCount: state.cities.length,
                cardBuilder: (BuildContext context,
                    int index,
                    int horizontalOffsetPercentage,
                    int verticalOffsetPercentage) {
                  return GestureDetector(
                      onTap: () {
                        context.read<GetAllCinemasBloc>().add(
                            GetAllCinemasEvent(
                                url: state.cities[index].urlCinemas));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CinemasPage(city: state.cities[index]),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.cities[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20),
                            ),
                            Image.asset(
                                "images/" + state.cities[index].name + ".png"),
                          ],
                        ),
                      ));
                },
              ),
            );
          }
          return Container();
        }));
  }
}
