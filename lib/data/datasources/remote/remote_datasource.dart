import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/manga_kitsu_model.dart';
import 'http_client.dart';

abstract class RemoteDataSource {
  Future<List<MangaKitsuModel>> getMangasFromTitle(String title);
  Future<List<MangaKitsuModel>> getMangasFromId(String id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static final _baseUri = Uri.parse('https://kitsu.io/api/edge/');

  final HttpClient _httpClient;

  RemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<MangaKitsuModel>> getMangasFromId(String id) async {
    final uri = _baseUri.replace(
      pathSegments: [
        ..._baseUri.pathSegments,
        'manga',
        id,
      ],
    );

    final response = await _httpClient.get<Map<String, dynamic>>(uri);
    if (response != null && response.containsKey('data')) {
      final data = (response['data'] as Iterable).cast<Map<String, dynamic>>();
      return data.map(MangaKitsuModel.fromJson).toList();
    }
    return [];
  }

  @override
  Future<List<MangaKitsuModel>> getMangasFromTitle(String title) async {
    final uri = _baseUri.replace(
      pathSegments: [
        ..._baseUri.pathSegments,
        'manga',
      ],
      queryParameters: {'filter[text]': title},
    );

    final response = await _httpClient.get<Map<String, dynamic>>(uri);
    if (response != null && response.containsKey('data')) {
      final data = (response['data'] as Iterable).cast<Map<String, dynamic>>();
      return data.map(MangaKitsuModel.fromJson).toList();
    }
    return [];
  }
}

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return RemoteDataSourceImpl(httpClient);
});
