import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/user/User.dart';

class Task {
  int id;
  User user;
  TaskBoard taskBoard;
  String title;
  String note;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  bool isDone;

  Task(this.id, this.user, this.taskBoard, this.title, this.note, this.date,
      this.startTime, this.endTime, this.isDone);

  @override
  String toString() {
    return 'Task{id: $id, user: $user, taskBoard: $taskBoard, title: $title, note: $note, date: $date, startTime: $startTime, endTime: $endTime, isDone: $isDone}';
  }
}
