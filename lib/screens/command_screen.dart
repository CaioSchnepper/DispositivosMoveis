import 'package:app_do_portao/models/automation_model.dart';
import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:app_do_portao/services/automation_service.dart';
import 'package:app_do_portao/widgets/arm_disarm_widget.dart';
import 'package:app_do_portao/widgets/open_gate_widget.dart';
import 'package:flutter/material.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key, required this.cliente});

  final ClienteModel cliente;

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  List<AutomationModel> _automations = List.empty();
  AutomationModel? _commandAbrirPortao;

  @override
  void initState() {
    _fetchCommands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Image.asset('lib/assets/images/comandos.gif'),
            ),
          ),
          _commandAbrirPortao != null
              ? const OpenGateWidget()
              : ArmDisarmWidget(
                  cliente: widget.cliente, automation: _automations.firstOrNull),
        ],
      ),
    );
  }

  void _fetchCommands() async {
    List<AutomationModel> automations =
        await AutomationService.fetchAutomations(widget.cliente.idUnico);

    int abrirPortaoIndex = automations.indexWhere((automation) => automation
        .comandos
        .any((command) => _commandContainsPortao(command.nome)));

    setState(() {
      _automations = automations;

      if (abrirPortaoIndex >= 0) {
        _commandAbrirPortao = automations[abrirPortaoIndex];
      }
    });
  }

  bool _commandContainsPortao(String nome) {
    const String portaoWithTilde = "Portão";
    const String portaoWithoutTilde = "Portao";

    return nome.contains(portaoWithTilde) ||
        nome.contains(portaoWithTilde.toLowerCase()) ||
        nome.contains(portaoWithoutTilde) ||
        nome.contains(portaoWithoutTilde.toLowerCase());
  }
}
