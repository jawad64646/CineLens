import 'package:dio/dio.dart';

mixin GetErrorMessage {
  String getErrorMessage(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];

      if (message != null) {
        return message.toString();
      }
    }

    if (data is String && data.isNotEmpty) {
      return data;
    }

    return e.message ?? 'An error occurred';
  }
}
