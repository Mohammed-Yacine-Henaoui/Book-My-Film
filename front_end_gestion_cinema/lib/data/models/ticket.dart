class Ticket {
  late int price;
  late String nameCustomer;
  late int codePayement;
  late bool payed;
  late String urlSeat;
  late String urlMySelf;

  Ticket.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    nameCustomer = json['nameCustomer'];
    codePayement = json['codePayement'];
    payed = json['payed'];
    urlSeat = json["_links"]["seat"]["href"];
    urlMySelf = json["_links"]["self"]["href"];
  }
}
