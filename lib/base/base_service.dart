import 'dart:developer';

import 'package:awesome_app/base/environment.dart';
import 'package:awesome_app/base/log_interceptor.dart';
import 'package:dio/dio.dart';

class ApiCore {
  ApiCore._internal(this._dio);
  static late final ApiCore call;
  late final Dio _dio;

  static void initialize() {
    call = ApiCore._internal(
      Dio(BaseOptions(baseUrl: Environment.base_url))
        ..interceptors.add(APILogInterceptor()),
    );
  }

  Future<Options> _buildOptions({
    Map<String, dynamic>? headers,
    int sendTimeout = 60000,
    int receiveTimeout = 60000,
  }) async {
    final Map<String, dynamic> newHeaders = {
      'Accept': 'application/json',
    };

    newHeaders.addAll(headers ?? {});
    if (!newHeaders.containsKey("Authorization")) {
      newHeaders["Authorization"] = Environment.key;
    }

    return Options(
      headers: newHeaders,
      sendTimeout: Duration(milliseconds: sendTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
    );
  }

  Future<T> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final options = await _buildOptions(headers: headers);
      final response = await _dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return fromJson(response.data ?? {});
    } catch (e) {
      _handleError(e, endpoint);
      rethrow;
    }
  }

  void _handleError(dynamic e, String endpoint) {
    if (e is DioException) {
      if (CancelToken.isCancel(e)) {
        log('Request to $endpoint was cancelled.');
      } else {
        log('DioException: ${e.response?.data}');
      }
    } else {
      log('Exception: $e');
    }
  }
}
