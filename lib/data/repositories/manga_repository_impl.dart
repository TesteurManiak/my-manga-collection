import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/platform/network_info.dart';
import '../../domain/entities/manga.dart';
import '../../domain/entities/result.dart';
import '../../domain/repositories/manga_repository.dart';
import '../datasources/local/local_datasource.dart';
import '../datasources/remote/remote_datasource.dart';

class MangaRepositoryImpl implements MangaRepository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  MangaRepositoryImpl({
    required NetworkInfo networkInfo,
    required RemoteDataSource remoteDataSource,
    required LocalDataSource localDataSource,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource {
    _localDataSource.watchMangas().listen(_favoriteMangaSubject.add);
    unawaited(fetchFavorites());
  }

  final _favoriteMangaSubject = BehaviorSubject<List<Manga>>();

  @override
  Future<Result<List<Manga>, Object>> searchMangas(String title) async {
    try {
      final mangas = <String, Manga>{};

      final localMangas = await _localDataSource.getMangasFromTitle(title);
      for (final manga in localMangas) {
        mangas[manga.id] = manga;
      }

      final isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final apiMangas = await _remoteDataSource.getMangasFromTitle(title);
        for (final manga in apiMangas) {
          mangas.putIfAbsent(manga.id, () => manga);
        }
      }
      return Result.value(mangas.values.toList());
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<void> addMangaToFavorite(Manga manga) {
    return _localDataSource.saveManga(manga);
  }

  @override
  Stream<List<Manga>> watchFavorites() => _favoriteMangaSubject.stream;

  @override
  Future<List<Manga>> fetchFavorites() async {
    final localFavorites = await _localDataSource.getAllMangas();
    _favoriteMangaSubject.add(localFavorites);
    return localFavorites;
  }

  @override
  Future<void> removeMangaFromFavorite(Manga manga) {
    return _localDataSource.removeManga(manga);
  }
}

final mangaRepositoryProvider = Provider.autoDispose<MangaRepository>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  final localDataSource = ref.watch(localDataSourceProvider);

  ref.onDispose(localDataSource.dispose);

  return MangaRepositoryImpl(
    networkInfo: networkInfo,
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

final favoriteChangeProvider = StreamProvider.autoDispose<List<Manga>>((ref) {
  final repository = ref.watch(mangaRepositoryProvider);
  return repository.watchFavorites();
});
