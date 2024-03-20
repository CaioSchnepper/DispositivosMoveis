import 'package:app_do_portao/utils/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';

class OpenGateWidget extends StatefulWidget {
  const OpenGateWidget({super.key});

  @override
  State<OpenGateWidget> createState() => _OpenGateWidgetState();
}

class _OpenGateWidgetState extends State<OpenGateWidget> {
  static const double maxAngle = -1.5;
  static const double angleToTrigger = -1.2;
  double currentAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset("lib/assets/images/gate/gate-no-bar.png"),
              GestureDetector(
                onPanUpdate: _onPanUpdateHandler,
                child: SizedBox(
                  width: 270,
                  child: Transform.rotate(
                    angle: currentAngle,
                    origin: const Offset(24, 0),
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Image.asset("lib/assets/images/gate/gate-bar.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Levante a cancela para abrir o portão.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  void _onPanUpdateHandler(DragUpdateDetails details) {
    final touchPositionFromCenter = details.localPosition;

    if (_isInvalidAngle(touchPositionFromCenter.direction)) {
      return;
    }

    if (touchPositionFromCenter.direction < angleToTrigger) {
      SnackBarHelper.show(context, 'Abrindo portão hehe');
      setState(() {
        currentAngle = 0.0;
      });
      return;
    }

    setState(() {
      currentAngle = touchPositionFromCenter.direction;
    });
  }

  bool _isInvalidAngle(double angle) => angle < maxAngle || angle > 0;
}
