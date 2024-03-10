import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  final String title = 'Title';

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          FilledButton(
              child: const Text('Voltar'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        result = scanData;

        if (scanData.format == BarcodeFormat.qrcode && scanData.code != null) {
          dando pau aqui
          // Load and obtain the shared preferences for this app.
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('qrCodeData', scanData.code!);
          Navigator.pop(context);
        } else {
          const snackBar = SnackBar(
            content: Text('QR Code inválido'),
            duration: Durations.long1,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
