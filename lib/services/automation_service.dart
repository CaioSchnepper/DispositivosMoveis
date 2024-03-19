import 'dart:convert';
import 'dart:io';

import 'package:app_do_portao/models/automation_model.dart';
import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:app_do_portao/utils/constants/api_constants.dart';
import 'package:app_do_portao/utils/helpers/http_helper.dart';

class AutomationService {
  static Future<List<AutomationModel>> fetchAutomations(int idUnico) async {
    String? apiUrl = await StorageService.getApiUrl();

    final response = await HttpHelper.client.get(Uri.parse(
        '$apiUrl/${ApiConstants.baseUrl}/patrimonios/$idUnico/automacoes'));

    if (response.statusCode == HttpStatus.ok) {
      var decodedBody = jsonDecode(response.body) as List<dynamic>;
      return decodedBody.map((item) => AutomationModel.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao buscar automações');
    }
  }
}
