class TaskBoard {
  final int id;
  final String name;
  final int color;

  TaskBoard({required this.id, required this.name, required this.color});

  factory TaskBoard.fromMap(Map<String, dynamic> map) {
    return TaskBoard(
      id: map['id'],
      name: map['name'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}
