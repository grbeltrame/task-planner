import 'package:flutter/material.dart';
import 'package:projeto_final/contexts/user.context.dart';
import 'package:projeto_final/controllers/User.controller.dart';
import 'package:projeto_final/models/user/User.dto.credentials.dart';
import 'package:projeto_final/models/user/User.dto.newUser.dart';
import 'package:projeto_final/pages/dashboard_page.dart';
import 'package:projeto_final/utils/Validation.register.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  final Function() changeWidgetForm;
  final UserController userController;

  const RegisterForm({
    super.key,
    required this.changeWidgetForm,
    required this.userController,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final Map<String, bool> _validationStatus = {
    'username': true,
    'email': true,
    'password': true,
    'confirmPassword': true,
    'formValidation': true,
    'userAlreadyCreated': true,
  };

  void _updateValidationStatus(String field, bool status) {
    setState(() {
      _validationStatus[field] = status;
    });
  }

  void _register() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    _updateValidationStatus(
        'username', ValidationRegister.validateUsername(username));
    _updateValidationStatus('email', ValidationRegister.validateEmail(email));
    _updateValidationStatus(
        'password', ValidationRegister.validatePassword(password));
    _updateValidationStatus('confirmPassword',
        ValidationRegister.validateConfirmPassword(password, confirmPassword));

    _updateValidationStatus(
        'formValidation',
        _validationStatus["username"]! &&
            _validationStatus["email"]! &&
            _validationStatus["password"]! &&
            _validationStatus["confirmPassword"]!);

    if (!_validationStatus['formValidation']!) {
      return;
    }

    UserDtoNewUser registeredUser = UserDtoNewUser(username, email, password);

    final registrationSuccess =
        await widget.userController.registerUser(registeredUser);

    _updateValidationStatus('userAlreadyCreated', registrationSuccess);

    if (registrationSuccess) {
      final user = await widget.userController
          .loginUser(UserDtoCredentials(username, password));

      var userProvider = Provider.of<UserProvider>(context, listen: false);

      userProvider.updateUser(user!);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardPage(
                  user: user,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black45,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "REGISTER",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Container(
              height: 420,
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
                      controller: _emailController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        errorText: !_validationStatus['email']!
                            ? "Email not valid"
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
                  Container(
                    child: TextField(
                      controller: _confirmPasswordController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        border: OutlineInputBorder(),
                        labelText: 'Repeat password',
                        errorText: !_validationStatus['confirmPassword']!
                            ? "Passwords are not the same"
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36,
              child: !_validationStatus['userAlreadyCreated']!
                  ? Text(
                      "Username or email already taken",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : null,
            ),
            Container(
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Cor do botão de login
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Borda arredondada
                  ),
                  minimumSize: Size(200, 50), // Tamanho do botão
                ),
                child: Text(
                  'Register',
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
                    "Do you have an account? Sign in",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
