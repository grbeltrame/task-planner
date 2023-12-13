import 'package:flutter/material.dart';
import 'package:projeto_final/models/TaskBoard.dart';
import 'package:projeto_final/utils/pastel_colors.dart';
import '/pages/tasks_page.dart';
import '/pages/search_page.dart';
import '/pages/recent_tasks_page.dart';
import '/pages/completed_tasks_page.dart';
import 'package:projeto_final/database/DatabaseProvider.dart';
import 'package:projeto_final/pages/widgets/quadro_de_tarefas_widget.dart';

class DashboardPage extends StatelessWidget {
  Future<List<TaskBoard>> getTaskBoards() async {
    return await DatabaseProvider.instance.getTaskBoards();
  }

  void _exibirDialogoAdicionarQuadro(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    int corSelecionada = 1; // Padrão para a primeira cor

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Novo Quadro'),
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
    // Lógica para adicionar o novo quadro ao banco de dados
    TaskBoard novoQuadro = TaskBoard(name: nome, color: cor);
    await DatabaseProvider.instance.addTaskBoard(novoQuadro, nome, cor);

    // Atualiza a lista de quadros (Se necessário)
    // setState(() {});

    // Pode adicionar lógica para navegar para a página do novo quadro, se necessário
  }

  Widget buildTaskBoardWidgets(BuildContext context) {
    return FutureBuilder<List<TaskBoard>>(
      future: getTaskBoards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Erro: ${snapshot.error}');
          return Text('Erro: ${snapshot.error}');
        } else {
          List<TaskBoard> taskBoards = snapshot.data ?? [];
          print('Número de quadros: ${taskBoards.length}');
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        title: Text(
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
              // Implementar lógica para deslogar
              Navigator.pop(context);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'deslogar',
                child: Text('Deslogar', style: TextStyle(color: Colors.white)),
              ),
              PopupMenuItem<String>(
                value: 'pesquisar',
                child: Text('Pesquisar', style: TextStyle(color: Colors.white)),
              ),
              PopupMenuItem<String>(
                value: 'tarefas_recentes',
                child: Text('Tarefas Recentes',
                    style: TextStyle(color: Colors.white)),
              ),
              PopupMenuItem<String>(
                value: 'tarefas_concluidas',
                child: Text('Tarefas Concluídas',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
              PopupMenuItem<String>(
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
