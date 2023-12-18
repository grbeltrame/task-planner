import 'package:flutter/material.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/pages/tasks_page.dart';

// Widget para exibir cada quadro de tarefas
class QuadroTarefasWidget extends StatelessWidget {
  final TaskBoard taskBoard;
  final Color color;

  QuadroTarefasWidget({required this.taskBoard, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Implementar lógica para clicar no quadro e ver as tarefas
        try {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TarefasPage(taskBoard: taskBoard),
              ));
        } catch (error) {
          print('Erro ao navegar para a página de pesquisa: $error');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              taskBoard.name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tarefas: 0',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
