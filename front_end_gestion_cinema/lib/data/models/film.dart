import 'package:front_end_gestion_cinema/data/models/category.dart';

class Film {
  late String title;
  //late String description;
  //late String director;
  //late String releaseDate;
  late String duration;
  late String image;
  late String urlCategory;
  Category category = Category();

  Film(){}

  Film.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    //description = json['description'];
    //director = json['director'];
    //releaseDate = json['releaseDate'];
    duration = json['duration'];
    image = json['image'];
    urlCategory = json["_links"]["category"]["href"];
  }
}
