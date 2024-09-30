import 'package:front_end_gestion_cinema/data/models/seat.dart';

class GetSeatFromTicketStates {}

class SuccessGetSeatFromTicketStates extends GetSeatFromTicketStates {
  final Seat seat;

  SuccessGetSeatFromTicketStates({required this.seat});
}

class FailledGetSeatFromTicketStates extends GetSeatFromTicketStates {
  final String errorMessage;

  FailledGetSeatFromTicketStates({required this.errorMessage});
  
}

class LoadingGetSeatFromTicketStates extends GetSeatFromTicketStates {}
