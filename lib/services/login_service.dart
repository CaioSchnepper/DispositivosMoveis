import 'dart:convert';
import 'dart:io';

import 'package:dispositivos_moveis/models/login_model.dart';
import 'package:dispositivos_moveis/models/qrcode_model.dart';
import 'package:dispositivos_moveis/services/storage_service.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static const String AUTH_URL = 'api/iris-security';

  static Future<http.Response> login(String user, String password) async {
    final QRCodeModel qrCodeData = await StorageService.getQRCodeData();
    final LoginModel loginModel =
        LoginModel(applicationId: '', celular: user, senha: password);

    final response = await http.post(
        Uri.parse('${qrCodeData.url}/$AUTH_URL/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'TenantId': qrCodeData.tenantId
        },
        body: jsonEncode(loginModel.toJson()));

    if (response.statusCode == HttpStatus.ok) {
      // return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      return response;
    } else {
      throw Exception('Erro ao realizar login');
    }
  }
}
