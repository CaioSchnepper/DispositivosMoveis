import 'dart:async';

import 'package:app_do_portao/models/automation_model.dart';
import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:app_do_portao/services/automation_service.dart';
import 'package:app_do_portao/utils/helpers/automations_helper.dart';
import 'package:app_do_portao/utils/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';

class OpenGateWidget extends StatefulWidget {
  const OpenGateWidget(
      {super.key, required this.cliente, required this.automation});

  final ClienteModel cliente;
  final AutomationModel automation;

  @override
  State<OpenGateWidget> createState() => _OpenGateWidgetState();
}

class _OpenGateWidgetState extends State<OpenGateWidget> {
  static const double _maxAngle = -1.5;
  static const double _angleToTrigger = -1.1;

  Timer? _timer;
  double _currentAngle = 0.0;

  bool _panEndTriggered = false;
  bool _gateTriggeredSoftly = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset("lib/assets/images/gate/gate-no-bar.png"),
                GestureDetector(
                  onPanUpdate: _onPanUpdateHandler,
                  onPanEnd: _onPanEndHandler,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 38, bottom: 40),
                    child: SizedBox(
                      width: 300,
                      child: Transform.rotate(
                        angle: _currentAngle,
                        origin: const Offset(27, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Image.asset(
                              "lib/assets/images/gate/gate-bar.png"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                _gateTriggeredSoftly
                    ? "Levante a cancela QUE NEM GENTE para abrir o portão."
                    : "Levante a cancela para abrir o portão.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPanUpdateHandler(DragUpdateDetails details) {
    final touchPositionFromCenter = details.localPosition;

    if (_panEndTriggered == true ||
        _isInvalidAngle(touchPositionFromCenter.direction)) {
      return;
    }

    setState(() {
      _currentAngle = touchPositionFromCenter.direction;
    });
  }

  void _onPanEndHandler(DragEndDetails details) {
    _panEndTriggered = true;

    if (_currentAngle < _angleToTrigger) {
      _sendCommand();
      _gateTriggeredSoftly = false;
    } else {
      _gateTriggeredSoftly = true;
    }

    const double angleIncrement = 0.05;

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (_currentAngle <= 0) {
        double newAngle = _currentAngle + angleIncrement;
        setState(() {
          _currentAngle = newAngle;
        });
      } else {
        _panEndTriggered = false;
        _timer?.cancel();
        setState(() {
          _currentAngle = 0.0;
        });
      }
    });
  }

  bool _isInvalidAngle(double angle) => angle < _maxAngle || angle > 0;

  Future<void> _sendCommand() async {
    ComandoModel openGateCommand = widget.automation.comandos.firstWhere(
        (command) => AutomationsHelper.commandContainsPortao(command.nome));

    ComandoSendModel commandToSend = ComandoSendModel(
        comandoId: openGateCommand.idComando,
        integracaoId: widget.automation.idIntegracao,
        zona: null);

    try {
      await AutomationService.sendCommand(
          widget.cliente.idUnico, commandToSend);

      SnackBarHelper.show(context, "Comandinho de abrir portão enviado.");
    } catch (exception) {
      SnackBarHelper.show(context, "Erro ao enviar comando, tente novamente.");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
