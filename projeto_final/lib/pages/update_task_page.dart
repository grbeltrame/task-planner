import 'package:flutter/material.dart';
import 'package:projeto_final/contexts/user.context.dart';
import 'package:projeto_final/controllers/Task.controller.dart';
import 'package:projeto_final/models/task/Task.dart';
import 'package:projeto_final/models/task/Task.dto.modifyTask.dart';
import 'package:provider/provider.dart';

class UpdateTaskPage extends StatefulWidget {
  final Task task;

  const UpdateTaskPage({super.key, required this.task});

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  Future<void> updateTask(BuildContext context) async {
    TaskController taskController = TaskController();
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    String title = titleController.text;
    String note = noteController.text;

    TaskDtoModifyTask modifiedTask = TaskDtoModifyTask(
      widget.task.id,
      userProvider.loggedUser.id,
      widget.task.idTaskBoard,
      title,
      note,
      widget.task.date,
      widget.task.startTime,
      widget.task.endTime,
      false,
    );

    await taskController.updateTask(modifiedTask);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.task.title;
    noteController.text = widget.task.note;

    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Tarefa'),
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
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Digite o novo título da tarefa',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nota:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Digite a nova nota para a tarefa',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => updateTask(context),
              child: Text('Atualizar Tarefa'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }
}
