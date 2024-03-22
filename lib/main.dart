import 'dart:async';

import 'package:app_do_portao/models/login_model.dart';
import 'package:app_do_portao/models/qrcode_model.dart';
import 'package:app_do_portao/screens/login_screen.dart';
import 'package:app_do_portao/screens/patrimony_screen.dart';
import 'package:app_do_portao/screens/qrcode_scanner_screen.dart';
import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _opacityText1 = 0;
  double _opacityText2 = 0;
  double _opacityButton = 0;

  @override
  void initState() {
    super.initState();
    _checkSavedData();
    _timersForOpacity();
  }

  _checkSavedData() async {
    LoginResponseModel? loginData = await StorageService.getLoginData();
    if (loginData != null) {
      _navigateToPatrimonyScreen();
      return;
    }

    QRCodeModel? qrCodeData = await StorageService.getQRCodeData();
    if (qrCodeData != null) {
      _navigateToLoginScreen();
      return;
    }
  }

  void _timersForOpacity() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _opacityText1 = 1;
      });
    });

    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        _opacityText2 = 1;
      });
    });

    Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        _opacityButton = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: _opacityText1,
              duration: const Duration(seconds: 2),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Olá',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _opacityText2,
              duration: const Duration(seconds: 2),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Por favor, pressione o botão abaixo e escaneie o QR Code fornecido para ter acesso ao App do portão',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _opacityButton,
              duration: const Duration(seconds: 2),
              child: FilledButton(
                onPressed: _navigateToQRCodeScanner,
                style: ButtonStyle(
                    textStyle: MaterialStatePropertyAll(TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize)),
                    elevation: const MaterialStatePropertyAll(4),
                    minimumSize: const MaterialStatePropertyAll(Size(200, 50))),
                child: const Text('Abrir câmera'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToQRCodeScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRCodeScannerScreen()),
    );
  }

  void _navigateToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _navigateToPatrimonyScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PatrimonyScreen()),
    );
  }
}
