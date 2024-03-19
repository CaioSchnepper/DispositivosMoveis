import 'dart:convert';
import 'dart:io';

import 'package:app_do_portao/models/qrcode_model.dart';
import 'package:app_do_portao/screens/login_screen.dart';
import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:app_do_portao/utils/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  final String title = 'Title';

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
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

      _handleQRCode(scanData.code!);
    });
  }

  void _handleQRCode(String data) async {
    try {
      final qrCodeDataJson = jsonDecode(data) as Map<String, dynamic>;

      // Tentando instanciar pra ver se tem os dados corretos
      QRCodeModel.fromJson(qrCodeDataJson);

      HapticFeedback.vibrate();

      // Load and obtain the shared preferences for this app.
      await StorageService.saveQRCodeData(data);

      _navigateToLoginScreen();
    } catch (exception) {
      _showSnackBar('QR Code inválido');
      qrViewController!.resumeCamera();
    }
  }

  void _navigateToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _showSnackBar(String text) {
    SnackBarHelper.show(context, text);
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }
}
