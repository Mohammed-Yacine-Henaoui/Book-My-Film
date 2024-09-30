class GetCinemasEvent {}

class GetAllCinemasEvent extends GetCinemasEvent {
  final String url;

  GetAllCinemasEvent({required this.url});
}
