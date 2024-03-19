import 'package:app_do_portao/models/automation_model.dart';
import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:app_do_portao/services/automation_service.dart';
import 'package:flutter/material.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key, required this.cliente});

  final String title = 'Login';
  final ClienteModel cliente;

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  List<AutomationModel> _automations = List.empty();

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
          Center(
            child: Column(
              children: <Widget>[
                for (var automation in _automations)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.location_city,
                          size: 40,
                        ),
                        title: Text(automation.nome),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(automation.comandos.first.valorComando),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _fetchCommands() async {
    List<AutomationModel> automations =
        await AutomationService.fetchAutomations(widget.cliente.idUnico);

    setState(() {
      _automations = automations;
    });
  }
}
