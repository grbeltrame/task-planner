class TaskBoard {
  final int id;
  final String name;
  final int color;

  TaskBoard(this.id, this.name, this.color);

  @override
  String toString() {
    return 'TaskBoard{id: $id, name: $name, color: $color}';
  }
}
