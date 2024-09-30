class GetTicketsEvents {}

class GetTicketsOfFilmScreeningEvent extends GetTicketsEvents {
  final String urlTickets;

  GetTicketsOfFilmScreeningEvent({required this.urlTickets});
  
}
