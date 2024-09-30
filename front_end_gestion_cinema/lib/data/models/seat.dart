class Seat {
  late int number;
  Seat(){}

  Seat.fromJson(Map<String, dynamic> json) {
    number = json['number'];
  }
}
