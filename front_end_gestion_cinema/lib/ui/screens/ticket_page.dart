import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_seat_from_ticket/get_seat_from_ticket_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_seat_from_ticket/get_seat_from_ticket_events.dart';
import 'package:front_end_gestion_cinema/controller/get_seat_from_ticket/get_seat_from_ticket_states.dart';
import 'package:front_end_gestion_cinema/data/models/filmScreening.dart';
import 'package:front_end_gestion_cinema/data/models/ticket.dart';
import 'package:front_end_gestion_cinema/functions/error_dialog.dart';
import 'package:front_end_gestion_cinema/functions/my_patch_http.dart';
import 'package:front_end_gestion_cinema/functions/validate_champ_consumer.dart';
import 'package:front_end_gestion_cinema/functions/validate_champ_payement.dart';
import 'package:front_end_gestion_cinema/ui/screens/cities_page.dart';
import 'package:front_end_gestion_cinema/ui/widgets/build_divider.dart';
import 'package:front_end_gestion_cinema/ui/widgets/build_info_row.dart';
import 'package:front_end_gestion_cinema/ui/widgets/failled_get_all_cities_state_widget.dart';
import 'package:front_end_gestion_cinema/ui/widgets/loading_get_all_cities_state_widget.dart';
import 'package:front_end_gestion_cinema/ui/widgets/my_text_form_field.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketPage extends StatelessWidget {
  final Ticket ticket;
  final int index;
  final FilmScreening filmScreening;
  const TicketPage(
      {super.key,
      required this.ticket,
      required this.index,
      required this.filmScreening});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController consumerNameController = TextEditingController();
    TextEditingController payementCodeController = TextEditingController();
    String animationLoading = "animation_tickets.gif";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket"),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<GetSeatFromTicketBloc, GetSeatFromTicketStates>(
          builder: (context, state) {
        if (state is FailledGetSeatFromTicketStates) {
          ErrorDialog(context, state.errorMessage);
          return FailledGetAllCitiesStateWidget(
            context,
            () {
              context
                  .read<GetSeatFromTicketBloc>()
                  .add(GetSeatFromTicketEvent(urlSeat: ticket.urlSeat));
            },
          );
        } else if (state is LoadingGetSeatFromTicketStates) {
          return LoadingGetAllCitiesStateWidget(animationLoading);
        } else if (state is SuccessGetSeatFromTicketStates) {
          return Center(
            child: TicketWidget(
              color: Theme.of(context).canvasColor,
              margin: EdgeInsets.all(5),
              width: double.maxFinite,
              height: double.maxFinite,
              isCornerRounded: true,
              padding: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(children: [
                  Text(
                    "N° " + index.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  BuildInfoRow("Film", filmScreening.film.title),
                  BuildDivider(265, context),
                  BuildInfoRow("Category", filmScreening.film.category.name),
                  BuildDivider(235, context),
                  BuildInfoRow("Start date", filmScreening.startDate),
                  BuildDivider(230, context),
                  BuildInfoRow("Time", filmScreening.sessionFilmScreening.time),
                  BuildDivider(260, context),
                  BuildInfoRow("Duration", filmScreening.film.duration),
                  BuildDivider(240, context),
                  BuildInfoRow("Room name", filmScreening.room.name),
                  BuildDivider(215, context),
                  BuildInfoRow("Seat number", state.seat.number.toString()),
                  BuildDivider(212, context),
                  BuildInfoRow("Consumer name", ticket.nameCustomer),
                  BuildDivider(185, context),
                  BuildInfoRow("Payement code", ticket.codePayement.toString()),
                  BuildDivider(192, context),
                  BuildInfoRow("Price", ticket.price.toString() + " DA"),
                  BuildDivider(258, context),
                  ticket.payed == false
                      ? ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        Text("fill out the reservation form:"),
                                    actions: [
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            MyTextFormField(
                                              my_icon: Icons.person,
                                              obscure_text_psw: false,
                                              my_controller:
                                                  consumerNameController,
                                              my_hint: "Consumer Name",
                                              my_validator:
                                                  ValidateChampConsumer,
                                            ),
                                            MyTextFormField(
                                              my_icon: Icons.paypal_rounded,
                                              obscure_text_psw: true,
                                              my_controller:
                                                  payementCodeController,
                                              my_hint: "Payement Code",
                                              my_validator:
                                                  ValidateChampPayement,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      MyPatchHttp(
                                                              ticket.urlMySelf,
                                                              {
                                                                "nameCustomer":
                                                                    consumerNameController
                                                                        .text,
                                                                "codePayement":
                                                                    int.tryParse(
                                                                        payementCodeController
                                                                            .text),
                                                                "payed": true,
                                                              },
                                                              context,
                                                              "Reservation done successfully",
                                                              "Reservation failed")
                                                          .then((_) {
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      CitiesPage()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false,
                                                        );
                                                      });
                                                    }
                                                  },
                                                  child: Text("Reserve"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Fermer"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          label: Text("Reserve"),
                          icon: Icon(Icons.monetization_on_outlined),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                        )
                      : Center(
                          child: Container(
                            width: 50,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Payed",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                ]),
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
