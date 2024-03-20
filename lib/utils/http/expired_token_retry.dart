import 'dart:convert';
import 'dart:io';

import 'package:app_do_portao/models/login_model.dart';
import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:app_do_portao/utils/constants/api_constants.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 3;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode != HttpStatus.unauthorized) {
      return false;
    }

    try {
      await _refreshToken();
      return true;
    } catch (exception) {
      return false;
    }
  }

  Future<void> _refreshToken() async {
    String? refreshToken = await StorageService.getRefreshToken();
    String? tenantId = await StorageService.getTenantId();
    String? accessToken = await StorageService.getAccessToken();
    String? apiUrl = await StorageService.getApiUrl();

    final RefreshTokenModel refreshTokenModel =
        RefreshTokenModel(const Uuid().v4(), refreshToken!);

    final response = await http.post(
        Uri.parse('${apiUrl!}/${ApiConstants.baseUrl}/refresh-token'),
        headers: {
          "Content-Type": ApiConstants.applicationContentType,
          "TenantId": tenantId!,
          "Authorization": "Bearer $accessToken"
        },
        body: jsonEncode(refreshTokenModel.toJson()));

    if (response.statusCode == HttpStatus.ok) {
      LoginResponseModel loginData = LoginResponseModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);

      StorageService.saveLoginData(loginData);
    } else {
      throw Exception('Erro ao realizar o refresh token');
    }
  }
}
