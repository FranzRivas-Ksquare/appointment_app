class Appointment {
  static int id = 1;
  String title;
  String? description;
  DateTime due;
  int author;

  Appointment({id, required this.title, this.description, required this.due, required this.author});
}