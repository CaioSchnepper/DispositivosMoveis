import 'package:app_do_portao/models/login_model.dart';
import 'package:app_do_portao/screens/patrimony_screen.dart';
import 'package:app_do_portao/services/login_service.dart';
import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:app_do_portao/utils/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  final String title = 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '(###)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          height: 400.0,
          width: 250.0,
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: Image.asset('lib/assets/images/robot-dance.gif'),
          ),
        ),
        Text(
          'Usuário',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
              controller: userController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Informe seu usuário',
              ),
              inputFormatters: [maskFormatter]),
        ),
        Text(
          'Senha',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Informa a senha',
            ),
          ),
        ),
        FilledButton(
          onPressed: () {
            _login();
          },
          child: const Text('Login'),
        ),
      ]),
    );
  }

  Future<void> _login() async {
    try {
      LoginResponseModel login = await LoginService.login(
          userController.text, passwordController.text);
      StorageService.saveLoginData(login);
      _navigateToPatrimonyScreen();
    } catch (exception) {
      _showSnackBar(
          'Erro ao realizar login. O que aconteceu nós nunca saberemos.');
    }
  }

  _showSnackBar(String text) {
    SnackBarHelper.show(context, text);
  }

  _navigateToPatrimonyScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PatrimonyScreen()),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
