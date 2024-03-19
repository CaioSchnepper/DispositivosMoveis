import 'package:app_do_portao/utils/http/expired_token_retry.dart';
import 'package:app_do_portao/utils/http/http_interceptor.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class HttpHelper {
  static final client = InterceptedClient.build(
    interceptors: [AuthorizationInterceptor()],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );
}
