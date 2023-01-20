import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User {
  String? name;
  String email;
  String password;
  Uint8List? avatar;

  User({this.name, required this.email, required this.password, this.avatar});

  User.fromRow(Map<String, Object?> row)
      : name = row['NAME'] as String?,
        email = row['EMAIL'] as String,
        password = row['PASSWORD'] as String,
        avatar = row['AVATAR'] as Uint8List?;

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
      return const AssetImage('assets/images/avatar.jpeg');
    } else {
      return MemoryImage(avatar!);
    }
  }
}
