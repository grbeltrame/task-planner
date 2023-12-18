import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/Task.controller.dart';
import 'package:projeto_final/models/task/Task.dto.modifyTask.dart';
import 'package:projeto_final/models/task/Task.dart';

class UpdateTaskPage extends StatelessWidget {
  final Task task;

  UpdateTaskPage({required this.task});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  Future<void> updateTask(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    titleController.text = task.title;
    noteController.text = task.note;

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
