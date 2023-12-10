import 'package:projeto_final/models/user/User.dart';
import 'package:projeto_final/models/user/User.dto.newUser.dart';
import 'package:sqflite/sqflite.dart';

class UserTable {
  static const String _tableName = 'user';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _password = 'password';

  static Future<void> createUsersTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_name TEXT NOT NULL,
        $_email TEXT NOT NULL,
        $_password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      INSERT INTO $_tableName($_name, $_email, $_password) VALUES ('Teste 1', 'teste1@teste.com', '123456'),
      ('Teste 2', 'teste2@teste.com', '123456'),
      ('Teste 3', 'teste3@teste.com', '123456'),
      ('Teste 4', 'teste4@teste.com', '123456'),
      ('Teste 5', 'teste5@teste.com', '123456')
      ''');
  }

  static Future<void> insertUser(Database db, UserDtoNewUser newUser) async {
    await db.insert(
      _tableName,
      newUser.toMap(),
    );
  }

  static Future<List<User>> getUsers(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(
      maps.length,
      (index) {
        return User(
          maps[index][_id],
          maps[index][_name],
          maps[index][_email],
          maps[index][_password],
        );
      },
    );
  }

  static Future<User?> getUserByName(Database db, String userName) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    Map<String, dynamic>? userMap =
        maps.where((user) => user[_name] == userName).firstOrNull;

    if (userMap != null) {
      return User(
          userMap[_id], userMap[_name], userMap[_email], userMap[_password]);
    }
    return null;
  }

  static Future<bool> checkUsernameAvailability(
      Database db, String userName) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    Map<String, dynamic>? userMap =
        maps.where((user) => user[_name] == userName).firstOrNull;

    return userMap != null ? false : true;
  }

  static Future<bool> checkEmailAvailability(Database db, String email) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    Map<String, dynamic>? userMap =
        maps.where((user) => user[_email] == email).firstOrNull;

    return userMap != null ? false : true;
  }
}
