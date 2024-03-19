import 'package:app_do_portao/repositories/storage_service.dart';
import 'package:app_do_portao/utils/constants/api_constants.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthorizationInterceptor implements InterceptorContract {
  
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

}
