import 'package:app_do_portao/models/automation_model.dart';
import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:app_do_portao/services/automation_service.dart';
import 'package:app_do_portao/utils/constants/acao_enum.dart';
import 'package:app_do_portao/utils/helpers/automations_helper.dart';
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
  List<AutomationModel> _automations = List<AutomationModel>.empty();
  AutomationModel? _automationAbrirPortao;

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
          _automationAbrirPortao != null
              ? OpenGateWidget(
                  cliente: widget.cliente, automation: _automationAbrirPortao!)
              : ArmDisarmWidget(
                  cliente: widget.cliente,
                  automation: _automations.firstOrNull),
        ],
      ),
    );
  }

  void _fetchCommands() async {
    List<AutomationModel> automations =
        await AutomationService.fetchAutomations(widget.cliente.idUnico);

    int abrirPortaoIndex = automations.indexWhere((automation) =>
        automation.comandos.any((command) =>
            AutomationsHelper.commandContainsPortao(command.nome)));

    List<AutomationModel> automationsWithSupportedCommands =
        List<AutomationModel>.empty(growable: true);

    for (var automation in automations) {
      List<ComandoModel> newCommands = automation.comandos
          .where((comando) => AutomationsHelper.commandIsSupported(comando))
          .toList();

      AutomationModel newAutomation = AutomationModel(
          newCommands, automation.idIntegracao, automation.nome);

      automationsWithSupportedCommands.add(newAutomation);
    }

    setState(() {
      _automations = automationsWithSupportedCommands;

      if (abrirPortaoIndex >= 0) {
        _automationAbrirPortao = automations[abrirPortaoIndex];
      }
    });
  }
}
