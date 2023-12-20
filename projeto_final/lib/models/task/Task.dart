class Task {
  int id;
  int idUser;
  int idTaskBoard;
  String title;
  String note;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  bool isDone;

  Task(this.id, this.idUser, this.idTaskBoard, this.title, this.note, this.date,
      this.startTime, this.endTime, this.isDone);

  @override
  String toString() {
    return 'Task{id: $id, idUser: $idUser, idTaskBoard: $idTaskBoard, title: $title, note: $note, date: $date, startTime: $startTime, endTime: $endTime, isDone: $isDone}';
  }
}
