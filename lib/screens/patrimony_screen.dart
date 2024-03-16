import 'package:dispositivos_moveis/models/patrimony_model.dart';
import 'package:dispositivos_moveis/services/patrimony_service.dart';
import 'package:flutter/material.dart';

class PatrimonyScreen extends StatefulWidget {
  const PatrimonyScreen({super.key});

  final String title = 'Login';

  @override
  State<PatrimonyScreen> createState() => _PatrimonyScreenState();
}

class _PatrimonyScreenState extends State<PatrimonyScreen> {
  PatrimonyModel _patrimonies = PatrimonyModel();

  @override
  void initState() {
    _fetchPatrimonies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Column(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var cliente in _patrimonies.clientes)
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(cliente.nome)),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }

  void _fetchPatrimonies() async {
    PatrimonyModel patrimonies = await PatrimonyService.fetchPatrimonies();

    setState(() {
      _patrimonies = patrimonies;
    });
  }
}
