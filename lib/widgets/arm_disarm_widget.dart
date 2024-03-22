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
              (widget.automation?.comandos.isEmpty ?? true)
                  ? "Não há comandos disponíveis para esse patrimônio."
                  : "Deslize para enviar o comando.",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          for (var command
              in widget.automation?.comandos ?? List<ComandoModel>.empty())
            if (_shouldShowThisCommand(command))
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: SlideAction(
                  sliderRotate: false,
                  sliderButtonIcon: _getProperIcon(command),
                  animationDuration: const Duration(milliseconds: 500),
                  text: command.nome,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  //innerColor: Theme.of(context),
                  outerColor: Theme.of(context).colorScheme.surfaceVariant,
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
        try {
          await AutomationService.removeActivation(widget.cliente.idUnico);
          SnackBarHelper.show(context, "Comandinho de armar enviado.");
          return;
        } catch (exception) {
          SnackBarHelper.show(
              context, "Erro ao enviar o comando, tente novamente.");
          return;
        }

      case EnumAcao.desarmar:
        try {
          await AutomationService.removeDeactivation(widget.cliente.idUnico);
          SnackBarHelper.show(context, "Comandinho de desarmar enviado.");
          return;
        } catch (exception) {
          SnackBarHelper.show(
              context, "Erro ao enviar o comando, tente novamente.");
          return;
        }

      case EnumAcao.inibirZonas:
        SnackBarHelper.show(context, "Comandinho não suportado ainda hehe");
        return;
    }
  }

  bool _shouldShowThisCommand(ComandoModel command) {
    switch (command.enumAcao) {
      case EnumAcao.armar:
        return !widget.cliente.armado;
      case EnumAcao.desarmar:
        return widget.cliente.armado;
      default:
        return true;
    }
  }

  Icon _getProperIcon(ComandoModel command) {
    switch (command.enumAcao) {
      case EnumAcao.armar:
        return const Icon(Icons.lock, color: Colors.red);
      case EnumAcao.desarmar:
        return const Icon(Icons.lock_open, color: Colors.green);
      default:
        return const Icon(Icons.block, color: Colors.black);
    }
  }
}
