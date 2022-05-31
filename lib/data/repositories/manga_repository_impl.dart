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
  final _fetchedMangaSubject = BehaviorSubject<List<Manga>>();

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
      _fetchedMangaSubject.add(mangas.values.toList());
      return Result.value(mangas.values.toList());
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void, Object>> addMangaToFavorite(Manga manga) async {
    try {
      final result = await _localDataSource.saveManga(manga);
      return Result.value(result);
    } catch (e) {
      return Result.error(e);
    }
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
  Future<Result<void, Object>> removeMangaFromFavorite(Manga manga) async {
    try {
      final result = _localDataSource.removeManga(manga);
      return Result.value(result);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void, Object>> editManga(Manga newManga) async {
    try {
      final result = await _localDataSource.updateManga(newManga);
      return Result.value(result);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  List<Manga> getFavorites() => _favoriteMangaSubject.value;

  @override
  List<Manga> getFetchedMangas() => _fetchedMangaSubject.value;

  @override
  Future<void> dispose() async {
    await _favoriteMangaSubject.close();
    await _fetchedMangaSubject.close();
  }
}

final mangaRepositoryProvider = Provider<MangaRepository>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  final localDataSource = ref.watch(localDataSourceProvider);

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
