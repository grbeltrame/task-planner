import 'package:projeto_final/models/user/User.dart';
import 'package:projeto_final/models/user/User.dto.credentials.dart';
import 'package:projeto_final/models/user/User.dto.newUser.dart';
import 'package:projeto_final/services/User.service.dart';

class UserController {
  final UserService _userService = UserService();

  Future<User?> loginUser(UserDtoCredentials userDtoCredentials) {
    return _userService.authenticateUser(userDtoCredentials);
  }

  Future<bool> registerUser(UserDtoNewUser userDtoNewUser) {
    return _userService.registerUser(userDtoNewUser);
  }

  Future<int?> getUserId(UserDtoCredentials userDtoCredentials) async {
    User? user = await loginUser(userDtoCredentials);
    return user?.id;
  }
}
