import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/User.controller.dart';
import 'package:projeto_final/models/user/User.dto.credentials.dart';
import 'package:projeto_final/pages/dashboard_page.dart';
import 'package:projeto_final/utils/Validation.register.dart';

class LoginForm extends StatefulWidget {
  final Function() changeWidgetForm;
  final UserController userController;

  const LoginForm({
    super.key,
    required this.changeWidgetForm,
    required this.userController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Map<String, bool> _validationStatus = {
    'username': true,
    'password': true,
    'formValidation': true,
    'userLoggedIn': true,
  };

  void _updateValidationStatus(String field, bool status) {
    setState(() {
      _validationStatus[field] = status;
    });
  }

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    _updateValidationStatus(
        'username', ValidationRegister.validateUsername(username));
    _updateValidationStatus(
        'password', ValidationRegister.validatePassword(password));

    _updateValidationStatus('formValidation',
        _validationStatus["username"]! && _validationStatus["password"]!);

    if (!_validationStatus['formValidation']!) {
      return;
    }

    UserDtoCredentials loggedUser = UserDtoCredentials(username, password);

    final user = await widget.userController.loginUser(loggedUser);

    _updateValidationStatus('userLoggedIn', user != null);

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black45,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: TextField(
                    controller: _usernameController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                      labelText: "Username",
                      errorText: !_validationStatus['username']!
                          ? "The username must be at least 6 characters"
                          : null,
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: _passwordController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_rounded),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      errorText: !_validationStatus['password']!
                          ? "The password must be at least 6 characters"
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 36,
            child: !_validationStatus['userLoggedIn']!
                ? Text(
                    "User not found",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : null,
          ),
          Container(
            child: ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Cor do botão de login
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Borda arredondada
                ),
                minimumSize: Size(200, 50), // Tamanho do botão
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: GestureDetector(
              onTap: widget.changeWidgetForm,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  "Don't you have an account? Sign up",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
