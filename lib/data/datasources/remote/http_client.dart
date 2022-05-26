import 'package:dio/dio.dart';

abstract class HttpClient {
  Future<T?> get<T>(Uri uri);
}

class DioClient implements HttpClient {
  final Dio _dio;

  DioClient({required Dio dio}) : _dio = dio;

  @override
  Future<T?> get<T>(Uri uri) async {
    final response = await _dio.getUri<T>(uri);
    return response.data;
  }
}
