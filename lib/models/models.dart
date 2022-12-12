class User {
  static int id = 1;
  String? name;
  String email;
  String password;

  User({id, this.name, required this.email, required this.password});
}

class Appointment {
  static int id = 1;
  String title;
  String? description;
  DateTime due;
  int author;

  Appointment(
      {id, required this.title, this.description, required this.due, required this.author});
}