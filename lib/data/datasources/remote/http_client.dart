import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final dioProvider = Provider<Dio>((_) => Dio());

final httpClientProvider = Provider<HttpClient>((ref) {
  final dio = ref.watch(dioProvider);
  return DioClient(dio: dio);
});
