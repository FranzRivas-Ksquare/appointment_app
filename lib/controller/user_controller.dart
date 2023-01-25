import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/user_db.dart';
import '../models/user_model.dart';
import '../controller/database_service.dart';

class UserCtrl extends ChangeNotifier {

  User? currentUser;

  //--User services
  Future<bool> signUpUser(BuildContext context, User user) async {
    final UserDB refUserDB = context.read<DatabaseService>().getUserDB;
    bool validate = await refUserDB.create(user);
    if (validate) {
      currentUser = user;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<int> signInUser(BuildContext context, String email, String password) async {
    final UserDB refUserDB = context.read<DatabaseService>().getUserDB;
    User? tempUser = await refUserDB.fetchUser(email);
    if (tempUser == null) {
      return 2;
    }
    if (tempUser.password == password) {
      currentUser = tempUser;
      notifyListeners();
      return 0;
    } else {
      return 1;
    }
  }

  Future<bool> updateUser(BuildContext context, User user) async {
    final UserDB refUserDB = context.read<DatabaseService>().getUserDB;
    bool validate = await refUserDB.update(user);
    if (validate) {
      currentUser = user;
      return true;
    } else {
      return false;
    }
  }

  get getCurrentUser => currentUser;
}