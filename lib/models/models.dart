class User {
  String? name;
  String email;
  String password;

  User({this.name, required this.email, required this.password});

  User.fromRow(Map<String, Object?> row)
      : name = row['NAME'] as String,
        email = row['EMAIL'] as String,
        password = row['PASSWORD'] as String;

  @override
  String toString() {
    return 'User {$name\nemail: $email\npassword: $password}';
  }
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