import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/user/User.dart';

class TaskDtoNewTask {
  int idUser;
  int idTaskBoard;
  String title;
  String note;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  bool isDone;

  TaskDtoNewTask(this.idUser, this.idTaskBoard, this.title, this.note,
      this.date, this.startTime, this.endTime, this.isDone);

  Map<String, dynamic> toMap() {
    return {
      'user_id': idUser,
      'task_board_id': idTaskBoard,
      'title': title,
      'note': note,
      'date': date.toString(),
      'start_time': startTime.toString(),
      'end_time': endTime.toString(),
      'is_completed': isDone ? 1 : 0,
    };
  }
}
