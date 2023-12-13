import 'package:sqflite/sqflite.dart';
import 'package:projeto_final/models/TaskBoard.dart';

class TaskBoardTable {
  static const String _tableName = 'task_board';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _color = 'color';

  static Future<void> createTaskBoardTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        $_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_name VARCHAR NOT NULL,
        $_color INTEGER NOT NULL
      );
    ''');

    await db.execute('''
      INSERT INTO $_tableName($_name, $_color) VALUES 
     ('Trabalho', 1),
     ('Saúde', 2),
     ('Estudo', 3),
     ('Flutter', 4),
     ('Academia', 5)
      ''');
  }

  static Future<void> insertTaskBoard(
      Database db, TaskBoard taskBoard, String nome, int color) async {
    await db.insert(
      _tableName,
      taskBoard.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<TaskBoard>> getTaskBoards(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return TaskBoard.fromMap(maps[i]);
    });
  }

  static Future<bool> checkTaskBoardNameAvailability(
      Database db, String taskBoardName) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    Map<String, dynamic>? taskBoardMap = maps
        .where((taskBoard) => taskBoard[_name] == taskBoardName)
        .firstOrNull;

    return taskBoardMap != null ? false : true;
  }
}
