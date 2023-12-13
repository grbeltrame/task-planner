import 'package:projeto_final/database/tables/User.table.dart';
import 'package:projeto_final/database/tables/Taskboard.table.dart';
import 'package:projeto_final/models/user/User.dart';
import 'package:projeto_final/models/TaskBoard.dart';
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
    await TaskBoardTable.createTaskBoardTable(db);
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

  Future<List<TaskBoard>> getTaskBoards() async {
    final db = await database;
    final result = await db?.query('task_board');
    print('Resultado da query task_board: $result');
    return result?.map((map) => TaskBoard.fromMap(map)).toList() ?? [];
  }

  Future<void> addTaskBoard(TaskBoard taskBoard, String nome, int color) async {
    final db = await database;
    await TaskBoardTable.insertTaskBoard(db!, taskBoard, nome, color);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Lógica para atualizações de esquema
    await TaskBoardTable.createTaskBoardTable(db);
  }
}
