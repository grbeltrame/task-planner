import 'package:flutter/material.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';

class TarefasPage extends StatelessWidget {
  final TaskBoard taskBoard;

  TarefasPage({required this.taskBoard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          taskBoard.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black12,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Você esta na pagina da tarefa ${taskBoard.id}",
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }
}
