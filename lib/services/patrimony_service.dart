import 'dart:convert';
import 'dart:io';

import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:app_do_portao/utils/constants/api_constants.dart';
import 'package:app_do_portao/utils/http/http_interceptor.dart';

class PatrimonyService {
  static Future<PatrimonyModel> fetchPatrimonies() async {
    String? apiUrl = await StorageService.getApiUrl();

    final response = await HttpInterceptor.client
        .get(Uri.parse('$apiUrl/${ApiConstants.baseUrl}/patrimonios'));

    if (response.statusCode == HttpStatus.ok) {
      return PatrimonyModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Erro ao buscar patrimônios');
    }
  }
}
