import 'package:dio/dio.dart';
import 'package:pokemon_app_gravity/core/common/app_strings.dart';

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
      throw Exception(AppStrings.errorLoadingData);
    }
  }
}
