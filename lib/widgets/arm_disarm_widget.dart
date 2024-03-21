import 'package:app_do_portao/models/automation_model.dart';
import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:flutter/material.dart';

class ArmDisarmWidget extends StatefulWidget {
  const ArmDisarmWidget(
      {super.key, required this.cliente, required this.automations});

  final ClienteModel cliente;
  final List<AutomationModel> automations;

  @override
  State<ArmDisarmWidget> createState() => _ArmDisarmWidgetState();
}

class _ArmDisarmWidgetState extends State<ArmDisarmWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          for (var automation in widget.automations)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.location_city,
                    size: 40,
                  ),
                  title: Text(automation.comandos.first.nome),
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
    );
  }
}
