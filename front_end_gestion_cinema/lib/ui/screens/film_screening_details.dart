import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_gestion_cinema/contants/http_urls.dart';
import 'package:front_end_gestion_cinema/controller/get_seat_from_ticket/get_seat_from_ticket_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_seat_from_ticket/get_seat_from_ticket_events.dart';
import 'package:front_end_gestion_cinema/controller/get_tickets/get_tickets_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_tickets/get_tickets_events.dart';
import 'package:front_end_gestion_cinema/controller/get_tickets/get_tickets_states.dart';
import 'package:front_end_gestion_cinema/data/models/filmScreening.dart';
import 'package:front_end_gestion_cinema/data/models/ticket.dart';
import 'package:front_end_gestion_cinema/functions/error_dialog.dart';
import 'package:front_end_gestion_cinema/ui/screens/ticket_page.dart';
import 'package:front_end_gestion_cinema/ui/widgets/build_divider.dart';
import 'package:front_end_gestion_cinema/ui/widgets/build_info_row.dart';
import 'package:front_end_gestion_cinema/ui/widgets/failled_get_all_cities_state_widget.dart';
import 'package:front_end_gestion_cinema/ui/widgets/loading_get_all_cities_state_widget.dart';

class FilmScreeningDetails extends StatelessWidget {
  final FilmScreening filmScreening;
  const FilmScreeningDetails({super.key, required this.filmScreening});
  @override
  build(BuildContext context) {
    String animationLoading = "animation_tickets.gif";
    String animationLoadingImage = 'images/loadingImage.gif';
    ScrollController _scrollController = ScrollController();
    return Scaffold(
        appBar: AppBar(
          title: Text(filmScreening.film.title + " Film"),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: Theme.of(context).canvasColor,
            child: ListView(
              controller: _scrollController,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: animationLoadingImage,
                  image: HttpUrls.baseUrl +
                      '/imageFilm/' +
                      filmScreening.film.image,
                ),
                Text(
                  filmScreening.film.title,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                BuildInfoRow("Category", filmScreening.film.category.name),
                BuildDivider(275, context),
                BuildInfoRow("Start date", filmScreening.startDate),
                BuildDivider(272, context),
                BuildInfoRow("Time", filmScreening.sessionFilmScreening.time),
                BuildDivider(300, context),
                BuildInfoRow("Duration", filmScreening.film.duration),
                BuildDivider(275, context),
                BuildInfoRow("Price", filmScreening.price.toString() + " DA"),
                BuildDivider(295, context),
                BuildInfoRow("Room name", filmScreening.room.name),
                BuildDivider(255, context),
                BuildInfoRow("Tickets", ""),
                BuildDivider(280, context),
                BlocBuilder<GetTicketsBloc, GetTicketsStates>(
                  builder: (context, state) {
                    if (state is LoadingGetTicketsStates) {
                      return LoadingGetAllCitiesStateWidget(animationLoading);
                    } else if (state is FailledGetTicketsStates) {
                      ErrorDialog(context, state.errorMessage);
                      return FailledGetAllCitiesStateWidget(
                        context,
                        () {
                          context.read<GetTicketsBloc>().add(
                              GetTicketsOfFilmScreeningEvent(
                                  urlTickets: filmScreening.urlTickets));
                        },
                      );
                    } else if (state is SuccessGetTicketsStates) {
                      List<Ticket> tickets = state.tickets;
                      return GridView.builder(
                          padding: EdgeInsets.all(10),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            Ticket ticket = tickets[index];
                            return GestureDetector(
                              onTap: () {
                                  context.read<GetSeatFromTicketBloc>().add(
                                      GetSeatFromTicketEvent(
                                          urlSeat: ticket.urlSeat));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => TicketPage(
                                                ticket: ticket, index: index, filmScreening: filmScreening,
                                              )));
                              },
                              child: Card(
                                  color: ticket.payed == false
                                      ? Colors.green
                                      : Colors.red,
                                  child: Center(
                                    child: Text(
                                      index.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            );
                          });
                    }
                    return Container();
                  },
                )
              ],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.arrow_upward,
          ),
        ));
  }
}
