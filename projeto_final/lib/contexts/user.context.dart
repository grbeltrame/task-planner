import 'package:flutter/foundation.dart';
import 'package:projeto_final/models/user/User.dart';

class UserProvider extends ChangeNotifier {
  User loggedUser = User(0, "", "", "");

  void updateUser(User newLoggedUser) {
    loggedUser = newLoggedUser;
    notifyListeners();
  }
}
