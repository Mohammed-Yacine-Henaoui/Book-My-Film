class Cinema {
  late String name;
  late int numberOfRooms;
  late String urlRooms;

  Cinema.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    numberOfRooms = json['numberOfRooms'];
    urlRooms = json["_links"]["rooms"]["href"];
  }
}
