import 'dart:io';

import 'package:flutter/cupertino.dart';

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

  ImageProvider<Object> getAvatar() {
    if (avatar == null) {
      return const NetworkImage('https://picsum.photos/200/300');
    } else {
      return FileImage(File(avatar!));
    }
  }

}

class Appointment {
  final int? id;
  String title;
  String description;
  String date;
  String author;

  Appointment(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.author});

  Appointment.fromRow(Map<String, Object?> row)
      : id = row['ID'] as int,
        title = row['TITLE'] as String,
        description = row['DESCRIPTION'] as String,
        date = row['DATE'] as String,
        author = row['AUTHOR'] as String;

  @override
  String toString() {
    return 'User {title: $title\ndescription: $description\ndate: $date\nauthor: $author}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'author': author
    };
  }
}
