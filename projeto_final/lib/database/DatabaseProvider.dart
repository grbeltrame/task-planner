import 'package:projeto_final/database/tables/User.table.dart';
import 'package:projeto_final/models/user/User.dart';
import 'package:projeto_final/models/user/User.dto.newUser.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String _databaseName = 'AppDatabase.db';
  static const int _databaseVersion = 1;

  DatabaseProvider._privateConstructor();
  static final DatabaseProvider instance =
      DatabaseProvider._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database?> _initDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await UserTable.createUsersTable(db);
  }

  Future<void> insertUser(UserDtoNewUser newUser) async {
    final Database? db = await instance.database;

    await UserTable.insertUser(db!, newUser);
  }

  Future<List<User>> getUsers() async {
    final Database? db = await instance.database;

    final List<User> usersList = await UserTable.getUsers(db!);

    return usersList;
  }

  Future<User?> getUserByName(String userName) async {
    final Database? db = await instance.database;

    final User? user = await UserTable.getUserByName(db!, userName);

    return user;
  }

  Future<bool> checkUsernameAvailability(String userName, String email) async {
    final Database? db = await instance.database;

    final bool availability =
        await UserTable.checkUsernameAvailability(db!, userName) &&
            await UserTable.checkEmailAvailability(db, email);

    return availability;
  }
}
