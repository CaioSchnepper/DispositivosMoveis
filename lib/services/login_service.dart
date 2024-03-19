import 'dart:convert';
import 'dart:io';

import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:app_do_portao/utils/constants/api_constants.dart';
import 'package:app_do_portao/utils/http/http_interceptor.dart';
import 'package:app_do_portao/models/login_model.dart';

class LoginService {
  static Future<LoginResponseModel> login(String user, String password) async {
    String? apiUrl = await StorageService.getApiUrl();

    final LoginModel loginModel =
        LoginModel(applicationId: '', celular: user, senha: password);

    final response = await HttpInterceptor.client.post(
        Uri.parse('$apiUrl/${ApiConstants.baseUrl}/login'),
        body: jsonEncode(loginModel.toJson()));

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Erro ao realizar login');
    }
  }
}
