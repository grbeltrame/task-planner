import 'package:projeto_final/models/taskboard/TaskBoard.dto.newTaskBoard.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';

class TaskBoardTable {
  static const String _tableName = 'task_board';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _color = 'color';

  static Future<void> createTaskBoardTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_tableName (
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
      Database db, TaskBoardDtoNewTaskBoard taskBoardDtoNewTaskBoard) async {
    await db.insert(
      _tableName,
      taskBoardDtoNewTaskBoard.toMap(),
    );
  }

  static Future<List<TaskBoard>> getTaskBoards(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(
      maps.length,
      (index) {
        return TaskBoard(
          maps[index][_id],
          maps[index][_name],
          maps[index][_color],
        );
      },
    );
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
