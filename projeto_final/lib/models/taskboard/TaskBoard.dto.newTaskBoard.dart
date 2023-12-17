class TaskBoardDtoNewTaskBoard {
  final String name;
  final int color;

  TaskBoardDtoNewTaskBoard(this.name, this.color);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
    };
  }
}
