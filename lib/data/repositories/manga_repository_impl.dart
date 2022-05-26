import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/platform/network_info.dart';
import '../../domain/entities/manga.dart';
import '../../domain/repositories/manga_repository.dart';

class MangaRepositoryImpl implements MangaRepository {
  final NetworkInfo _networkInfo;

  MangaRepositoryImpl({required NetworkInfo networkInfo})
      : _networkInfo = networkInfo;

  @override
  Future<List<Manga>> fetchFavoriteMangas() {
    // TODO: implement fetchFavoriteMangas
    throw UnimplementedError();
  }

  @override
  Stream<List<Manga>> watchFavoriteMangas() {
    // TODO: implement watchFavoriteMangas
    throw UnimplementedError();
  }
}

final mangaRepositoryProvider = Provider<MangaRepository>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  return MangaRepositoryImpl(networkInfo: networkInfo);
});
