import 'package:flutter/material.dart';
import 'package:projeto_final/contexts/user.context.dart';
import 'package:projeto_final/controllers/Task.controller.dart';
import 'package:projeto_final/models/task/Task.dto.newTask.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/user/User.dart';
import 'package:provider/provider.dart';

class NewTaskPage extends StatefulWidget {
  final TaskBoard taskBoard;

  NewTaskPage({required this.taskBoard});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController noteController = TextEditingController();

  Future<void> addTask(BuildContext context) async {
    TaskController taskController = TaskController();
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    String title = titleController.text;
    String note = noteController.text;

    TaskDtoNewTask newTask = TaskDtoNewTask(
      userProvider.loggedUser.id,
      widget.taskBoard.id,
      title,
      note,
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      false,
    );

    await taskController.insertTask(newTask);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Tarefa', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black12,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título:',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Digite o título da tarefa',
                hintStyle: TextStyle(color: Colors.blueGrey),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nota:',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Digite uma nota para a tarefa',
                hintStyle: TextStyle(color: Colors.blueGrey),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => addTask(context),
              child: Text('Adicionar Tarefa'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }
}
