import 'package:projeto_final/models/task/Task.dart';
import 'package:projeto_final/models/task/Task.dto.newTask.dart';
import 'package:projeto_final/models/task/Task.dto.modifyTask.dart';
import 'package:projeto_final/services/Task.service.dart';
import 'package:projeto_final/database/tables/Task.table.dart';

class TaskController {
  final TaskService _taskService = TaskService();

  Future<void> insertTask(TaskDtoNewTask taskDtoNewTask) {
    return _taskService.insertTask(taskDtoNewTask);
  }

  Future<List<Task>> getTasksByUserId(int userId) {
    return _taskService.getTasksByUserId(userId);
  }

  Future<Task?> getTaskById(int taskId) {
    return _taskService.getTaskById(taskId);
  }

  Future<void> updateTask(TaskDtoModifyTask taskDtoModifyTask) {
    return _taskService.updateTask(taskDtoModifyTask);
  }

  Future<void> deleteTask(int taskId) {
    return _taskService.deleteTask(taskId);
  }
}
