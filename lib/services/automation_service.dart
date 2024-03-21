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

  static Future<bool> removeActivation(int idUnico) async {
    String? apiUrl = await StorageService.getApiUrl();

    final response = await HttpHelper.client.post(Uri.parse(
        '$apiUrl/${ApiConstants.baseUrl}/patrimonios/$idUnico/ativacao-remota'));

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      throw Exception('Erro ao ativar o patrimônio');
    }
  }

  static Future<bool> removeDeactivation(int idUnico) async {
    String? apiUrl = await StorageService.getApiUrl();

    final response = await HttpHelper.client.post(Uri.parse(
        '$apiUrl/${ApiConstants.baseUrl}/patrimonios/$idUnico/desativacao-remota'));

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      throw Exception('Erro ao desativar o patrimônio');
    }
  }

  static Future<bool> sendCommand(int idUnico, ComandoSendModel command) async {
    String? apiUrl = await StorageService.getApiUrl();

    final response = await HttpHelper.client.post(
        Uri.parse(
            '$apiUrl/${ApiConstants.baseUrl}/patrimonios/$idUnico/enviar-automacao'),
        body: jsonEncode(command.toJson()));

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      throw Exception('Erro ao enviar o comando');
    }
  }
}
