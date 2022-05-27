import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/platform/network_info.dart';
import '../../domain/entities/manga.dart';
import '../../domain/entities/result.dart';
import '../../domain/repositories/manga_repository.dart';
import '../datasources/remote/remote_datasource.dart';

class MangaRepositoryImpl implements MangaRepository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;

  MangaRepositoryImpl({
    required NetworkInfo networkInfo,
    required RemoteDataSource remoteDataSource,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<Manga>, Object>> searchMangas(String title) async {
    try {
      final isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final mangas = await _remoteDataSource.getMangasFromTitle(title);
        return Result.value(mangas);
      }
      return const Result.value([]);
    } catch (e) {
      return Result.error(e);
    }
  }
}

final mangaRepositoryProvider = Provider<MangaRepository>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return MangaRepositoryImpl(
    networkInfo: networkInfo,
    remoteDataSource: remoteDataSource,
  );
});
