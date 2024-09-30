class GetFilmScreeningEvent{}

class GetAllFilmScreenngEvent extends GetFilmScreeningEvent{
  final String urlRooms;

  GetAllFilmScreenngEvent({required this.urlRooms});
}