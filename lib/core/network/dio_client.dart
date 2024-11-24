import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(url, queryParameters: queryParameters);
    } catch (e) {
      throw Exception('Something went wrong!');
    }
  }
}
