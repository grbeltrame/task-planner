import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/Task.controller.dart';
import 'package:projeto_final/controllers/TaskBoard.controller.dart';
import 'package:projeto_final/models/task/Task.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dto.newTaskBoard.dart';
import 'package:projeto_final/models/user/User.dart';
import 'package:projeto_final/pages/completed_tasks_page.dart';
import 'package:projeto_final/pages/recent_tasks_page.dart';
import 'package:projeto_final/pages/search_page.dart';
import 'package:projeto_final/utils/pastel_colors.dart';
import 'package:projeto_final/pages/widgets/quadro_de_tarefas_widget.dart';

class DashboardPage extends StatefulWidget {
  final User user;

  const DashboardPage({
    super.key,
    required this.user,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TaskBoardController taskBoardController = TaskBoardController();
  TaskController taskController = TaskController();

  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    assignTasksFromDatabase();
  }

  Future<List<Task>> callTasksDatabase() async {
    List<Task> tasks = await taskController.getTasksByUserId(widget.user.id);

    return tasks;
  }

  Future<void> assignTasksFromDatabase() async {
    List<Task> tasksFromUser = await callTasksDatabase();

    setState(() {
      tasks = tasksFromUser;
    });
  }

  void _exibirDialogoAdicionarQuadro(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    int corSelecionada = 1; // Padrão para a primeira cor

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Novo Quadro'),
          content: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome do Quadro'),
              ),
              SizedBox(height: 16.0),
              Text('Cor:'),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: pastelColors.keys.map((cor) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      corSelecionada = cor;
                      _adicionarQuadro(
                          context, nomeController.text, corSelecionada);
                    },
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: pastelColors[cor],
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _adicionarQuadro(BuildContext context, String nome, int cor) async {
    TaskBoardDtoNewTaskBoard taskBoardDtoNewTaskBoard =
        TaskBoardDtoNewTaskBoard(nome, cor);

    final registrationSuccess =
        await taskBoardController.insertTaskBoard(taskBoardDtoNewTaskBoard);

    if (registrationSuccess) {
      setState(() {
        buildTaskBoardWidgets(context);
      });
    }

    // Falta implementar o que acontece quando o nome do quadro já existe
  }

  Widget buildTaskBoardWidgets(BuildContext context) {
    return FutureBuilder<List<TaskBoard>>(
      future: taskBoardController.getTaskBoards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Erro: ${snapshot.error}');
          return Text('Erro: ${snapshot.error}');
        } else {
          List<TaskBoard> taskBoards = snapshot.data ?? [];
          print('Número de quadros: ${taskBoards.length}');
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: taskBoards.length,
            itemBuilder: (context, index) {
              return QuadroTarefasWidget(
                taskBoard: taskBoards[index],
                color: pastelColors[taskBoards[index].color]!,
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black12,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            offset: Offset(0, 48),
            color: Colors.grey[800],
            onSelected: (value) {
              if (value == 'deslogar') {
                try {
                  Navigator.pop(context);
                } catch (error) {
                  print('Erro ao navegar para a página de pesquisa: $error');
                }
              } else if (value == 'pesquisar') {
                try {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new PesquisaPage(),
                      ));
                } catch (error) {
                  print('Erro ao navegar para a página de pesquisa: $error');
                }
              } else if (value == 'tarefas_recentes') {
                try {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new TarefasRecentesPage(),
                      ));
                } catch (error) {
                  print('Erro ao navegar para a página de pesquisa: $error');
                }
              } else if (value == 'tarefas_concluidas') {
                try {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new TarefasConcluidasPage(),
                      ));
                } catch (error) {
                  print('Erro ao navegar para a página de pesquisa: $error');
                }
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'deslogar',
                child: Text('Deslogar', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem<String>(
                value: 'pesquisar',
                child: Text('Pesquisar', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem<String>(
                value: 'tarefas_recentes',
                child: Text('Tarefas Recentes',
                    style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem<String>(
                value: 'tarefas_concluidas',
                child: Text('Tarefas Concluídas',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('MENU', style: TextStyle(color: Colors.white)),
            ),
          ),
          PopupMenuButton<String>(
            offset: Offset(0, 48),
            color: Colors.grey[800],
            onSelected: (value) {
              _exibirDialogoAdicionarQuadro(context);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'adicionar_quadro',
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8.0),
                    Text('Adicionar Novo Quadro',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildTaskBoardWidgets(context),
        ),
      ),
      backgroundColor: Colors.black87,
    );
  }
}
