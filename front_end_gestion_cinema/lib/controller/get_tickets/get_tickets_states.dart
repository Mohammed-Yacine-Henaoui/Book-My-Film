import 'package:front_end_gestion_cinema/data/models/ticket.dart';

class GetTicketsStates {}

class SuccessGetTicketsStates extends GetTicketsStates {
  final List<Ticket> tickets;

  SuccessGetTicketsStates({required this.tickets});
}

class FailledGetTicketsStates extends GetTicketsStates {
  final String errorMessage;

  FailledGetTicketsStates({required this.errorMessage});
}

class LoadingGetTicketsStates extends GetTicketsStates {}
