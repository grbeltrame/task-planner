import 'package:flutter/material.dart';
import 'package:projeto_final/contexts/user.context.dart';
import 'package:projeto_final/controllers/Task.controller.dart';
import 'package:projeto_final/models/task/Task.dto.modifyTask.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/task/Task.dart';
import 'package:projeto_final/pages/new_task_page.dart';
import 'package:projeto_final/pages/update_task_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TarefasPage extends StatefulWidget {
  final TaskBoard taskBoard;

  const TarefasPage({
    super.key,
    required this.taskBoard,
  });

  @override
  _TarefasPageState createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  TaskController taskController = TaskController();
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    assignTasksFromDatabase();
  }

  Future<List<Task>> callTasksDatabase() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Task> tasks = await taskController.getTasksByTaskBoardId(
        userProvider.loggedUser.id, widget.taskBoard.id);

    return tasks;
  }

  Future<void> assignTasksFromDatabase() async {
    List<Task> tasksFromUser = await callTasksDatabase();

    setState(() {
      tasks = tasksFromUser;
    });
  }

  Future<void> loadTasks() async {
    assignTasksFromDatabase();
  }

  Future<void> addTask() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewTaskPage(taskBoard: widget.taskBoard),
      ),
    ).then((result) {
      if (result != null) {
        loadTasks();
      }
    });
  }

  Future<void> updateTask(Task task) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTaskPage(task: task),
      ),
    ).then((result) {
      if (result != null) {
        loadTasks();
      }
    });
  }

  Future<void> deleteTask(Task task) async {
    await taskController.deleteTask(task.id);

    loadTasks();
  }

  Future<void> updateTaskStatus(Task task) async {
    TaskDtoModifyTask taskDtoModifyTask = TaskDtoModifyTask(
      task.id,
      task.idUser,
      task.idTaskBoard,
      task.title,
      task.note,
      task.date,
      task.startTime,
      task.endTime,
      !task.isDone,
    );

    await taskController.updateTask(taskDtoModifyTask);

    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskBoard.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black12,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: FutureBuilder(
          future: callTasksDatabase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: addTask, child: Text("Adicionar Tarefa")),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      return ListTile(
                          title: Text(task.title,
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text(
                              "Start date: ${DateFormat('dd/MM/yyyy').format(task.startTime)} \n End date: ${DateFormat('dd/MM/yyyy').format(task.endTime)}",
                              style: TextStyle(
                                  color: const Color.fromARGB(
                                      255, 196, 196, 196))),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            Checkbox(
                                value: task.isDone,
                                onChanged: (bool? value) {
                                  updateTaskStatus(task);
                                }),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => updateTask(task),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => deleteTask(task),
                            ),
                          ]));
                    },
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }
}
