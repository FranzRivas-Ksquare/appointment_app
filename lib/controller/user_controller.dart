import 'package:flutter/foundation.dart';
import '../models/models.dart';

class UserCtrl extends ChangeNotifier {

  User? currentUser;

  //--User services
  Future<bool> signUpUser(User user) async {
    bool validate = await userCtrl!.create(user);
    if (validate) {
      currentUser = user;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<int> signInUser(String email, String password) async {
    User? tempUser = await userCtrl!.fetchUser(email);
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

  Future<bool> updateUser(User user) async {
    bool validate = await userCtrl!.update(user);
    if (validate) {
      currentUser = user;
      return true;
    } else {
      return false;
    }
  }

  get getCurrentUser => currentUser;
}