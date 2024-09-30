class Room {
  late String name;
  late int numberOfSeats;
  late String urlFilmScreenings;
  late String urlSeats;

  Room(){}

  Room.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    numberOfSeats = json["numberOfSeats"];
    urlFilmScreenings = json["_links"]["filmScreenings"]["href"];
    urlSeats = json["_links"]["seats"]["href"];
  }
}
