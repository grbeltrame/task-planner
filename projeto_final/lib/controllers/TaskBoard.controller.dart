import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dto.newTaskBoard.dart';
import 'package:projeto_final/services/TaskBoard.service.dart';

class TaskBoardController {
  final TaskBoardService _taskBoardService = TaskBoardService();

  Future<List<TaskBoard>> getTaskBoards() {
    return _taskBoardService.getTaskBoards();
  }

  Future<bool> insertTaskBoard(
      TaskBoardDtoNewTaskBoard taskBoardDtoNewTaskBoard) {
    return _taskBoardService.insertTaskBoard(taskBoardDtoNewTaskBoard);
  }
}
