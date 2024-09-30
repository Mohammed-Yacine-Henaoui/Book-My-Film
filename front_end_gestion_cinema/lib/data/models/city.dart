class City {
  late String name;
  late String urlCinemas;

  City.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    urlCinemas = json["_links"]["cinemas"]["href"];
  }
}
