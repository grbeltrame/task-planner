import 'package:flutter/material.dart';
import 'package:projeto_final/contexts/user.context.dart';
import 'package:projeto_final/controllers/Task.controller.dart';
import 'package:projeto_final/models/task/Task.dart';
import 'package:provider/provider.dart';

class TarefasConcluidasPage extends StatefulWidget {
  @override
  State<TarefasConcluidasPage> createState() => _TarefasConcluidasPageState();
}

class _TarefasConcluidasPageState extends State<TarefasConcluidasPage> {
  TaskController taskController = TaskController();
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    assignTasksFromDatabase();
  }

  Future<List<Task>> callTasksDatabase() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Task> tasks =
        await taskController.getTasksByUserId(userProvider.loggedUser.id);

    return tasks;
  }

  Future<void> assignTasksFromDatabase() async {
    List<Task> tasksFromUser = await callTasksDatabase();

    List<Task> doneTasks = tasksFromUser.where((task) => task.isDone).toList();

    setState(() {
      tasks = doneTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Completed Tasks',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black12,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder(
        future: callTasksDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tasks[index].title),
                    subtitle: Text(tasks[index].note),
                    trailing: Text(tasks[index].isDone ? 'Done' : 'Not done'),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      backgroundColor: Colors.black87,
    );
  }
}
