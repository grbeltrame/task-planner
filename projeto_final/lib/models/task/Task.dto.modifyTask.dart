import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/user/User.dart';

class TaskDtoModifyTask {
  int id;
  int idUser;
  int idTaskBoard;
  String title;
  String note;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  bool isDone;

  TaskDtoModifyTask(this.id, this.idUser, this.idTaskBoard, this.title,
      this.note, this.date, this.startTime, this.endTime, this.isDone);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': idUser,
      'task_board_id': idTaskBoard,
      'title': title,
      'note': note,
      'date': date.toIso8601String(),
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'is_done': isDone ? 1 : 0,
    };
  }
}
