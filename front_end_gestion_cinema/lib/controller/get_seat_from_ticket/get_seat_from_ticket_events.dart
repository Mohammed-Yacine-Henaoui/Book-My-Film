class GetSeatFromTicketEvents {}

class GetSeatFromTicketEvent extends GetSeatFromTicketEvents {
  final String urlSeat;

  GetSeatFromTicketEvent({required this.urlSeat});
}
