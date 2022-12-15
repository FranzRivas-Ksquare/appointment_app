class User {
  String? name;
  String email;
  String password;
  String? avatar;

  User({this.name, required this.email, required this.password, this.avatar});

  User.fromRow(Map<String, Object?> row)
      : name = row['NAME'] as String,
        email = row['EMAIL'] as String,
        password = row['PASSWORD'] as String,
        avatar = row['AVATAR'] as String;

  @override
  String toString() {
    return 'User {name: $name\nemail: $email\npassword: $password\navatar: $avatar}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar
    };
  }
}

class Appointment {
  final int? id;
  String title;
  String? description;
  String date;
  String email;

  Appointment(
      {this.id,
      required this.title,
      this.description,
      required this.date,
      required this.email});

  Appointment.fromRow(Map<String, Object?> row)
      : id = row['ID'] as int,
        title = row['TITLE'] as String,
        description = row['DESCRIPTION'] as String,
        date = row['DATE'] as String,
        email = row['EMAIL'] as String;

  @override
  String toString() {
    return 'User {title: $title\ndescription: $description\ndate: $date\nauthor: $email}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'email': email
    };
  }
}
