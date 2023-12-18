import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/user/User.dart';

class TaskDtoModifyTask {
  int id;
  User user;
  TaskBoard taskBoard;
  String title;
  String note;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  bool isDone;

  TaskDtoModifyTask(this.id, this.user, this.taskBoard, this.title, this.note,
      this.date, this.startTime, this.endTime, this.isDone);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user.id,
      'task_board_id': taskBoard.id,
      'title': title,
      'note': note,
      'date': date.toIso8601String(),
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'is_done': isDone ? 1 : 0,
    };
  }
}
