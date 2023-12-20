import 'package:flutter/material.dart';
import 'package:projeto_final/contexts/user.context.dart';
import 'package:projeto_final/controllers/Task.controller.dart';
import 'package:projeto_final/models/task/Task.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/pages/tasks_page.dart';
import 'package:provider/provider.dart';

// Widget para exibir cada quadro de tarefas
class QuadroTarefasWidget extends StatefulWidget {
  final TaskBoard taskBoard;
  final Color color;

  const QuadroTarefasWidget({
    super.key,
    required this.taskBoard,
    required this.color,
  });

  @override
  State<QuadroTarefasWidget> createState() => _QuadroTarefasWidgetState();
}

class _QuadroTarefasWidgetState extends State<QuadroTarefasWidget> {
  TaskController taskController = TaskController();
  late int numberTasks;

  @override
  void initState() {
    super.initState();
    assignNumberTasksFromDatabase();
  }

  Future<List<Task>> callTasksDatabase() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Task> tasks =
        await taskController.getTasksByUserId(userProvider.loggedUser.id);

    return tasks;
  }

  Future<void> assignNumberTasksFromDatabase() async {
    List<Task> tasksFromUser = await callTasksDatabase();

    int numberTasks = tasksFromUser
        .where((task) => task.idTaskBoard == widget.taskBoard.id)
        .length;

    setState(() {
      this.numberTasks = numberTasks;
    });
  }

  Future<void> goToTasksPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TarefasPage(taskBoard: widget.taskBoard),
      ),
    ).then((result) {
      assignNumberTasksFromDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: callTasksDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return InkWell(
            onTap: () async {
              goToTasksPage();
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.taskBoard.name,
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
                      'Tarefas: $numberTasks',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

// InkWell(
//       onTap: () async {
//         goToTasksPage();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: widget.color,
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               widget.taskBoard.name,
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.black12,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12.0),
//                   topRight: Radius.circular(12.0),
//                   bottomLeft: Radius.circular(12.0),
//                   bottomRight: Radius.circular(12.0),
//                 ),
//               ),
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Tarefas: $numberTasks',
//                 style: TextStyle(fontSize: 14.0, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
