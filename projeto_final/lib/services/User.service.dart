import 'package:projeto_final/database/DatabaseProvider.dart';
import 'package:projeto_final/models/user/User.dart';
import 'package:projeto_final/models/user/User.dto.credentials.dart';
import 'package:projeto_final/models/user/User.dto.newUser.dart';

class UserService {
  Future<User?> authenticateUser(UserDtoCredentials credentials) async {
    final User? user =
        await DatabaseProvider.instance.getUserByName(credentials.name);

    if (user != null && user.password == credentials.password) {
      return user;
    }

    return null;
  }

  Future<bool> registerUser(UserDtoNewUser userDtoNewUser) async {
    final bool isUsernameAvailable = await DatabaseProvider.instance
        .checkUsernameAvailability(userDtoNewUser.name, userDtoNewUser.email);

    if (isUsernameAvailable) {
      await DatabaseProvider.instance.insertUser(userDtoNewUser);

      return true;
    }

    return false;
  }
}
