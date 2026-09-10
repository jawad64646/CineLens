import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';
import '../storage/storage_keys.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await SecureStorage().read(StorageKeys.accessToken);

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      // Catching any potential errors during token retrieval to prevent request hangs
    }

    print('REQUEST: ${options.method} ${options.uri}');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('ERROR: ${err.response?.statusCode} ${err.requestOptions.uri}');

    handler.next(err);
  }
}
