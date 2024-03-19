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
      themeMode: ThemeMode.dark,
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
  @override
  void initState() {
    super.initState();
    _checkSavedData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Olá',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Por favor, pressione o botão abaixo e escaneie o QR Code fornecido para ter acesso ao App do portão',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            FilledButton(
              onPressed: _navigateToQRCodeScanner,
              child: const Text('Abrir câmera'),
            )
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
