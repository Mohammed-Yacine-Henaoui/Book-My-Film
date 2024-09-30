import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cinemas/get_all_cinemas_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_cities/get_all_cities_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_all_film_screening.dart/get_all_film_screening_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_seat_from_ticket/get_seat_from_ticket_bloc.dart';
import 'package:front_end_gestion_cinema/controller/get_tickets/get_tickets_bloc.dart';
import 'package:front_end_gestion_cinema/root/my_root.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => GetAllCitiesBloc(),
      ),BlocProvider(
        create: (context) => GetAllCinemasBloc(),
      ),
      BlocProvider(
        create: (context) => GetAllFilmScreeningBloc(),
      ),
      BlocProvider(
        create: (context) => GetTicketsBloc(),
      ),
      BlocProvider(
        create: (context) => GetSeatFromTicketBloc(),
      ),
    ], child: MyRoot());
  }
}
