import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final/database/tables/Taskboard.table.dart';
import 'package:projeto_final/database/tables/User.table.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dart';
import 'package:projeto_final/models/taskboard/TaskBoard.dto.newTaskBoard.dart';
import 'package:projeto_final/models/user/User.dto.newUser.dart';
import 'package:projeto_final/pages/dashboard_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:projeto_final/main.dart';

void main() {
  sqfliteFfiInit();

  group('App Tests', () {
    late Database db;

    setUp(() async {
      // Configurar banco de dados temporário em memória para testes
      db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

      // Criar tabela de usuários
      await UserTable.createUsersTable(db);

      // Criar tabela de quadros de tarefas
      await TaskBoardTable.createTaskBoardTable(db);
    });

    tearDown(() async {
      // Fechar o banco de dados após cada teste
      await db.close();
    });

    testWidgets('DashboardPage UI Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Verifique se o widget DashboardPage está presente
      expect(find.byType(DashboardPage), findsOneWidget);

      // Adicione mais verificações de widgets conforme necessário
    });

    test('Insert TaskBoard', () async {
      // Criar usuário de exemplo
      final user = UserDtoNewUser('testUser', 'test@example.com', 'password');
      await UserTable.insertUser(db, user);

      // Criar quadro de tarefas de exemplo
      final taskBoard = TaskBoardDtoNewTaskBoard('Work', 1);

      // Inserir quadro de tarefas no banco de dados
      await TaskBoardTable.insertTaskBoard(db, taskBoard);

      // Obter lista de quadros de tarefas
      final taskBoards = await TaskBoardTable.getTaskBoards(db);

      // Verificar se o quadro de tarefas foi inserido corretamente
      expect(taskBoards.length, 1);
      expect(taskBoards[0].name, 'Work');
    });
  });
}
