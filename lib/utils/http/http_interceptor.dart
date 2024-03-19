import 'dart:convert';
import 'dart:io';

import 'package:app_do_portao/models/login_model.dart';
import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:app_do_portao/utils/constants/api_constants.dart';
import 'package:http_interceptor/http_interceptor.dart';

class HttpInterceptor extends RetryPolicy implements InterceptorContract {
  static Client client =
      InterceptedClient.build(interceptors: [HttpInterceptor()]);

  @override
  int get maxRetryAttempts => 3;

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    try {
      String? tenantId = await StorageService.getTenantId();
      String? accessToken = await StorageService.getAccessToken();

      request.headers["Content-Type"] = ApiConstants.applicationContentType;

      if (tenantId != null) {
        request.headers["TenantId"] = tenantId;
      }

      if (accessToken != null) {
        request.headers["Authorization"] = "Bearer $accessToken";
      }

      return request;
    } catch (exception) {
      return request;
    }
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) {
    return Future.sync(() => response);
  }

  @override
  Future<bool> shouldInterceptRequest() {
    return Future.sync(() => true);
  }

  @override
  Future<bool> shouldInterceptResponse() {
    return Future.sync(() => true);
  }

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

    if (refreshToken == null) {
      return;
    }

    final RefreshTokenModel refreshTokenModel =
        RefreshTokenModel('', refreshToken);

    final response = await HttpInterceptor.client.post(
        Uri.parse(
            '${StorageService.getApiUrl()}/${ApiConstants.baseUrl}/refresh-token'),
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
