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
  PatrimonyModel? _patrimonies;

  @override
  void initState() {
    super.initState();
    _fetchPatrimonies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: <Widget>[]),
    );
  }

  void _fetchPatrimonies() async {
    PatrimonyModel patrimonies = await PatrimonyService.fetchPatrimonies();

    setState(() {
      _patrimonies = patrimonies;
    });
  }
}
