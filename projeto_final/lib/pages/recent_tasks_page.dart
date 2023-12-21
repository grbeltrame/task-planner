import 'package:flutter/material.dart';
import 'package:projeto_final/contexts/user.context.dart';
import 'package:projeto_final/controllers/Task.controller.dart';
import 'package:projeto_final/models/task/Task.dart';
import 'package:provider/provider.dart';

class TarefasRecentesPage extends StatefulWidget {
  @override
  State<TarefasRecentesPage> createState() => _TarefasRecentesPageState();
}

class _TarefasRecentesPageState extends State<TarefasRecentesPage> {
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

    List<Task> recentTasks = tasksFromUser.where((task) {
      Duration durationInDays = DateTime.now().difference(task.startTime);

      int diffDays = durationInDays.inDays.abs();

      return diffDays <= 7;
    }).toList();

    setState(() {
      tasks = recentTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RecentTasks',
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
                Task task = tasks[index];

                return Card(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.note),
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
