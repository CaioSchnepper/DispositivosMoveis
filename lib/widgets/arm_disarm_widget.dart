import 'package:app_do_portao/models/automation_model.dart';
import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:app_do_portao/services/automation_service.dart';
import 'package:app_do_portao/utils/constants/acao_enum.dart';
import 'package:app_do_portao/utils/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ArmDisarmWidget extends StatefulWidget {
  const ArmDisarmWidget(
      {super.key, required this.cliente, required this.automation});

  final ClienteModel cliente;
  final AutomationModel? automation;

  @override
  State<ArmDisarmWidget> createState() => _ArmDisarmWidgetState();
}

class _ArmDisarmWidgetState extends State<ArmDisarmWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Deslize para enviar o comando.",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          for (var command
              in widget.automation?.comandos ?? List<ComandoModel>.empty())
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: SlideAction(
                sliderRotate: false,
                //sliderButtonIcon: const Icon(Icons.lock),
                animationDuration: const Duration(milliseconds: 500),
                text: command.nome,
                textStyle: Theme.of(context).primaryTextTheme.bodyLarge,
                //innerColor: Theme.of(context),
                outerColor: Theme.of(context).primaryColor,
                onSubmit: () => _sendCommand(command),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _sendCommand(ComandoModel command) async {
    switch (command.enumAcao) {
      case EnumAcao.armar:
        await AutomationService.removeActivation(widget.cliente.idUnico);
        SnackBarHelper.show(context, "Comandinho de armar enviado.");
        return;

      case EnumAcao.desarmar:
        await AutomationService.removeDeactivation(widget.cliente.idUnico);
        SnackBarHelper.show(context, "Comandinho de desarmar enviado.");
        return;

      case EnumAcao.inibirZonas:
        SnackBarHelper.show(context, "Comandinho não suportado ainda hehe");
        return;
    }
  }
}
