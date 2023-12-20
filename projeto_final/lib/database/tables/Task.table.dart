import 'package:projeto_final/models/task/Task.dart';
import 'package:projeto_final/models/task/Task.dto.newTask.dart';
import 'package:projeto_final/models/task/Task.dto.modifyTask.dart';
import 'package:sqflite/sqflite.dart';

class TaskTable {
  static const String _tableName = 'task';
  static const String _id = 'id';
  static const String _userId = 'user_id';
  static const String _taskBoardId = 'task_board_id';
  static const String _title = 'title';
  static const String _note = 'note';
  static const String _date = 'date';
  static const String _startTime = 'start_time';
  static const String _endTime = 'end_time';
  static const String _isCompleted = 'is_completed';

  static const String createTableScript = '''
    CREATE TABLE $_tableName (
      $_id INTEGER PRIMARY KEY AUTOINCREMENT,
      $_userId INTEGER NOT NULL,
      $_taskBoardId INTEGER NOT NULL,
      $_title VARCHAR NOT NULL,
      $_note TEXT NOT NULL,
      $_date VARCHAR NOT NULL,
      $_startTime VARCHAR NOT NULL,
      $_endTime VARCHAR NOT NULL,
      $_isCompleted INTEGER NOT NULL,
      FOREIGN KEY ($_userId) REFERENCES user ($_id),
      FOREIGN KEY ($_taskBoardId) REFERENCES task_board ($_id)
    )
  ''';

  static Future<void> createTaskTable(Database db) async {
    await db.execute(createTableScript);
  }

  static Future<void> insertTask(Database db, TaskDtoNewTask newTask) async {
    await db.insert(
      _tableName,
      newTask.toMap(),
    );
  }

  static Future<Task?> getTaskById(Database db, int taskId) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    Map<String, dynamic>? taskMap =
        maps.where((task) => task[_id] == taskId).firstOrNull;

    if (taskMap != null) {
      return Task(
        taskMap[_id],
        taskMap[_userId],
        taskMap[_taskBoardId],
        taskMap[_title],
        taskMap[_note],
        DateTime.parse(taskMap[_date]),
        DateTime.parse(taskMap[_startTime]),
        DateTime.parse(taskMap[_endTime]),
        taskMap[_isCompleted] == 1 ? true : false,
      );
    }

    return null;
  }

  static Future<List<Task>> getTasksByUserId(Database db, int userId) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    final List<Map<String, dynamic>> userTasks =
        maps.where((task) => task[_userId] == userId).toList();

    final List<Task> tasks = userTasks.map((task) {
      return Task(
        task[_id],
        task[_userId],
        task[_taskBoardId],
        task[_title],
        task[_note],
        DateTime.parse(task[_date]),
        DateTime.parse(task[_startTime]),
        DateTime.parse(task[_endTime]),
        task[_isCompleted] == 1 ? true : false,
      );
    }).toList();

    return tasks;
  }

  static Future<List<Task>> getTasksByTaskBoardId(
      Database db, int userId, int taskBoardId) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    final List<Map<String, dynamic>> userTaskBoardsTasks = maps
        .where((task) =>
            task[_userId] == userId && task[_taskBoardId] == taskBoardId)
        .toList();

    final List<Task> tasks = userTaskBoardsTasks.map((task) {
      return Task(
        task[_id],
        task[_userId],
        task[_taskBoardId],
        task[_title],
        task[_note],
        DateTime.parse(task[_date]),
        DateTime.parse(task[_startTime]),
        DateTime.parse(task[_endTime]),
        task[_isCompleted] == 1 ? true : false,
      );
    }).toList();

    return tasks;
  }

  static Future<void> updateTask(
      Database db, TaskDtoModifyTask taskDtoModifyTask) async {
    await db.update(
      _tableName,
      taskDtoModifyTask.toMap(),
      where: '$_id = ?',
      whereArgs: [taskDtoModifyTask.id],
    );
  }

  static Future<void> deleteTask(Database db, int taskId) async {
    await db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [taskId],
    );
  }
}
