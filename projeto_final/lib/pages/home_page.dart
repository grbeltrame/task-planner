import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/User.controller.dart';
import 'package:projeto_final/pages/widgets/login_form.dart';
import 'package:projeto_final/pages/widgets/register_form.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController _userController = UserController();

  bool onLoginForm = true;

  void changeWidgetForm() {
    setState(() {
      onLoginForm = !onLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Não tem necessidade de AppBar nessa pagina
      // O que está faltando:
      //   - implementação do login e cadastro, inteira,
      //   inclusive com a manipulação de banco de dados de acordo com a tabela fornecida no escopo

      backgroundColor: Colors.black87, // Alterado para um preto não tão preto
      body: Center(
        child: onLoginForm
            ? LoginForm(
                changeWidgetForm: changeWidgetForm,
                userController: _userController,
              )
            : RegisterForm(
                changeWidgetForm: changeWidgetForm,
                userController: _userController,
              ),
      ),
    );
  }
}
