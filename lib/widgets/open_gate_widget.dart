import 'package:flutter/material.dart';

class OpenGateWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const OpenGateWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Center(
          child: Image.asset('lib/assets/images/comandos.gif'),
        ),
        const Text('Levante a cancela para abrir o portão.')
      ]),
    );
  }
}
