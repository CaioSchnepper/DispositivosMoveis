import 'package:dispositivos_moveis/main.dart';
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

  final userNameController = TextEditingController();
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
              controller: userNameController,
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
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text that the user has entered by using the
                  // TextEditingController.
                  content: Text(userNameController.text),
                );
              },
            );
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (_) => const HomePage()));
          },
          child: const Text('Login'),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
