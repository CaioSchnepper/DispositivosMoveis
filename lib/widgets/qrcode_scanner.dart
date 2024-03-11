import 'dart:convert';
import 'dart:io';

import 'package:dispositivos_moveis/models/qrcode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Barcode? qrCodeData;
  QRViewController? qrViewController;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(children: <Widget>[
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    child: const Text('Voltar'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ]),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      qrViewController!.pauseCamera();
      setState(() {
        qrCodeData = scanData;
      });

      handleQRCode(scanData.code!);
    });
  }

  void handleQRCode(String data) async {
    try {
      final qrCodeDataJson = jsonDecode(data) as Map<String, dynamic>;

      // Tentando instanciar pra ver se tem os dados corretos
      QRCodeModel.fromJson(qrCodeDataJson);

      HapticFeedback.vibrate();

      // Load and obtain the shared preferences for this app.
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('QR_CODE_DATA', data);

      Navigator.pop(context);

    } catch (exception) {

      const snackBar = SnackBar(
        content: Text('QR Code inválido'),
        duration: Durations.long1,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      qrViewController!.resumeCamera();
    }
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }
}
