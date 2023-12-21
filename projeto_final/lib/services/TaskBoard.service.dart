import 'package:projeto_final/database/DatabaseProvider.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dto.newTaskBoard.dart';

class TaskBoardService {
  Future<List<TaskBoard>> getTaskBoards() async {
    final List<TaskBoard> taskBoardsList =
        await DatabaseProvider.instance.getTaskBoards();

    return taskBoardsList;
  }

  Future<bool> insertTaskBoard(
      TaskBoardDtoNewTaskBoard taskBoardDtoNewTaskBoard) async {
    final bool isTaskBoardNameAvailable = await DatabaseProvider.instance
        .checkTaskBoardNameAvailability(taskBoardDtoNewTaskBoard.name);

    if (isTaskBoardNameAvailable) {
      await DatabaseProvider.instance.insertTaskBoard(taskBoardDtoNewTaskBoard);

      return true;
    }

    return false;
  }
}
