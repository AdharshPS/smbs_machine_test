import 'dart:developer';

import 'package:dio/dio.dart';

class ApiServices {
  static Dio? _dio;
  static Dio getInstance() {
    _dio ??= Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 10),
        sendTimeout: Duration(seconds: 10),
      ),
    );
    bool hasInterceptors = _dio!.interceptors.any(
      (element) => element is InterceptorsWrapper,
    );
    if (!hasInterceptors) {
      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers = {
              'Content-Type': 'application/json',
              'x-api-key': 'reqres-free-v1',
            };
            options.responseType = ResponseType.plain;
            return handler.next(options);
          },
          onResponse: (response, handler) {
            log('response status: ${response.statusCode}');
            log('response data: ${response.data}');
            return handler.next(response);
          },
          onError: (error, handler) {
            log('error message: ${error.message}');
            log('error type: ${error.type}');
            return handler.next(error);
          },
        ),
      );
    }
    return _dio!;
  }
}
