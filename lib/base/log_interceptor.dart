import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class APILogInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('');
    debugPrint(
      (err.type == DioExceptionType.cancel) ? '# REQUEST CANCELLED' : '# ERROR',
    );
    debugPrint('<-- ${err.response?.statusCode} - ${err.requestOptions.uri}');
    debugPrint('Message: ${err.error}');
    debugPrint('<-- END HTTP');
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('');
    debugPrint('# REQUEST');
    final method = options.method.toUpperCase();
    debugPrint('--> $method - ${options.uri}');
    debugPrint('Headers: ${options.headers}');
    debugPrint('Data: ${options.data}');
    debugPrint('--> END $method');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint('');
    debugPrint('# RESPONSE');
    debugPrint('<-- ${response.statusCode} - ${response.requestOptions.uri}');
    debugPrint('Response: ${response.data}');
    debugPrint('<-- END HTTP');
    if (response.data is Map<String, dynamic>) {
      response.data["domain"] = response.requestOptions.baseUrl;
      response.data["status"] = response.data["status"] ?? response.statusCode;
      response.data["message"] =
          response.data["message"] ?? response.statusMessage;
      debugPrint("domain: ${response.data["domain"]}");
    } else {
      debugPrint("Caution not Json");
    }
    return super.onResponse(response, handler);
  }
}
