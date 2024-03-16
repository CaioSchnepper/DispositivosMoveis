import 'dart:convert';
import 'dart:io';

import 'package:app_do_portao/models/login_model.dart';
import 'package:app_do_portao/models/qrcode_model.dart';
import 'package:app_do_portao/services/storage_service.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static const String baseUrl = 'api/iris-security';

  static Future<LoginResponseModel> login(String user, String password) async {
    final QRCodeModel? qrCodeData = await StorageService.getQRCodeData();
    if (qrCodeData == null) {
      throw Exception('Erro ao ler os dados do QR Code');
    }

    final LoginModel loginModel =
        LoginModel(applicationId: '', celular: user, senha: password);

    final response = await http.post(
        Uri.parse('${qrCodeData.url}/$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'TenantId': qrCodeData.tenantId
        },
        body: jsonEncode(loginModel.toJson()));

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Erro ao realizar login');
    }
  }
}
