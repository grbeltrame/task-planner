import 'package:projeto_final/database/tables/Task.table.dart';
import 'package:projeto_final/database/tables/User.table.dart';
import 'package:projeto_final/database/tables/Taskboard.table.dart';
import 'package:projeto_final/models/task/Task.dart';
import 'package:projeto_final/models/task/Task.dto.newTask.dart';
import 'package:projeto_final/models/task/Task.dto.modifyTask.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dto.newTaskBoard.dart';
import 'package:projeto_final/models/user/User.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';
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
    await TaskTable.createTaskTable(db);
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
    final Database? db = await instance.database;

    final List<TaskBoard> taskBoardsList =
        await TaskBoardTable.getTaskBoards(db!);

    return taskBoardsList;
  }

  Future<void> insertTaskBoard(
      TaskBoardDtoNewTaskBoard taskBoardDtoNewTaskBoard) async {
    final db = await database;

    await TaskBoardTable.insertTaskBoard(db!, taskBoardDtoNewTaskBoard);
  }

  Future<bool> checkTaskBoardNameAvailability(String taskBoardName) async {
    final Database? db = await instance.database;

    final bool availability =
        await TaskBoardTable.checkTaskBoardNameAvailability(db!, taskBoardName);

    return availability;
  }

  Future<void> insertTask(TaskDtoNewTask newTask) async {
    final db = await database;

    await TaskTable.insertTask(db!, newTask);
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    final Database? db = await instance.database;

    final List<Task> tasksList = await TaskTable.getTasksByUserId(db!, userId);

    return tasksList;
  }

  Future<List<Task>> getTasksByTaskBoardId(int userId, int taskBoardId) async {
    final Database? db = await instance.database;

    final List<Task> tasksList =
        await TaskTable.getTasksByTaskBoardId(db!, userId, taskBoardId);

    return tasksList;
  }

  Future<Task?> getTaskById(int taskId) async {
    final Database? db = await instance.database;

    final Task? task = await TaskTable.getTaskById(db!, taskId);

    return task;
  }

  Future<void> updateTask(TaskDtoModifyTask taskDtoModifyTask) async {
    final Database? db = await instance.database;

    await TaskTable.updateTask(db!, taskDtoModifyTask);
  }

  Future<void> deleteTask(int taskId) async {
    final Database? db = await instance.database;

    await TaskTable.deleteTask(db!, taskId);
  }
}
