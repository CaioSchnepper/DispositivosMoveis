import 'dart:convert';
import 'dart:io';

import 'package:app_do_portao/models/login_model.dart';
import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:app_do_portao/models/qrcode_model.dart';
import 'package:app_do_portao/services/storage_service.dart';
import 'package:http/http.dart' as http;

class PatrimonyService {
  static const String baseUrl = 'api/iris-security';

  static Future<PatrimonyModel> fetchPatrimonies() async {
    final QRCodeModel? qrCodeData = await StorageService.getQRCodeData();
    if (qrCodeData == null) {
      throw Exception('Erro ao ler os dados do QR Code');
    }

    final LoginResponseModel? loginData = await StorageService.getLoginData();
    if (loginData == null) {
      throw Exception('Erro ao ler os dados do login');
    }

    final response = await http.get(
        Uri.parse('${qrCodeData.url}/$baseUrl/patrimonios'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'TenantId': qrCodeData.tenantId,
          'Authorization': 'Bearer ${loginData.accessToken}'
        });

    if (response.statusCode == HttpStatus.ok) {
      return PatrimonyModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Erro ao buscar patrimônios');
    }
  }
}
