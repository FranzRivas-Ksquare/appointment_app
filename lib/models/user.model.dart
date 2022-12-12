class User {
  static int id = 1;
  String? name;
  String email;
  String password;

  User({id, this.name, required this.email, required this.password});
}