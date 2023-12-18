import 'package:projeto_final/database/DatabaseProvider.dart';
import 'package:projeto_final/models/task/Task.dart';
import 'package:projeto_final/models/task/Task.dto.newTask.dart';
import 'package:projeto_final/models/task/Tasl.dto.modifyTask.dart';

class TaskService {
  Future<void> insertTask(TaskDtoNewTask taskDtoNewTask) async {
    await DatabaseProvider.instance.insertTask(taskDtoNewTask);
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    final List<Task> tasksList =
        await DatabaseProvider.instance.getTasksByUserId(userId);

    return tasksList;
  }

  Future<Task?> getTaskById(int taskId) async {
    final Task? task = await DatabaseProvider.instance.getTaskById(taskId);

    return task;
  }

  Future<void> updateTask(TaskDtoModifyTask taskDtoModifyTask) async {
    await DatabaseProvider.instance.updateTask(taskDtoModifyTask);
  }

  Future<void> deleteTask(int taskId) async {
    await DatabaseProvider.instance.deleteTask(taskId);
  }
}
