import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/platform/file_import.dart';
import '../../core/platform/file_manager.dart';
import '../../core/platform/network_info.dart';
import '../../domain/entities/manga.dart';
import '../../domain/entities/result.dart';
import '../../domain/repositories/manga_repository.dart';
import '../datasources/local/local_datasource.dart';
import '../datasources/remote/remote_datasource.dart';
import '../models/manga_kitsu_model.dart';

class MangaRepositoryImpl implements MangaRepository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final FileManager _fileManager;
  final FileImport _fileImport;

  MangaRepositoryImpl({
    required NetworkInfo networkInfo,
    required RemoteDataSource remoteDataSource,
    required LocalDataSource localDataSource,
    required FileManager fileManager,
    required FileImport fileImport,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _fileManager = fileManager,
        _fileImport = fileImport {
    _localDataSource.watchMangas().listen(_favoriteMangaSubject.add);
    unawaited(fetchFavorites());
  }

  final _favoriteMangaSubject = BehaviorSubject<List<Manga>>.seeded([]);
  final _fetchedMangaSubject = BehaviorSubject<List<Manga>>.seeded([]);

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
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  @override
  Stream<List<Manga>> watchSearchResults() => _fetchedMangaSubject.stream;

  @override
  Future<Result<void, Object>> addMangaToFavorite(Manga manga) async {
    try {
      final result = await _localDataSource.saveManga(manga);
      _updateFetchedMangaWith(manga);
      return Result.value(result);
    } catch (e) {
      debugPrint(e.toString());
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
      final fetchedMangas = List<Manga>.from(_fetchedMangaSubject.value);
      final mangaExists =
          fetchedMangas.firstWhereOrNull((e) => e.id == manga.id) != null;
      if (!mangaExists) {
        fetchedMangas.add(manga);
      }
      _fetchedMangaSubject.add(fetchedMangas);
      final result = await _localDataSource.removeManga(manga);
      return Result.value(result);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  @override
  Future<Result<void, Object>> editManga(Manga newManga) async {
    try {
      final result = await _localDataSource.updateManga(newManga);
      _updateFetchedMangaWith(newManga);
      return Result.value(result);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  void _updateFetchedMangaWith(Manga manga) {
    final fetchedMangas = List<Manga>.from(_fetchedMangaSubject.value);
    final index = fetchedMangas.indexWhere((e) => e.id == manga.id);
    if (index == -1) {
      fetchedMangas.add(manga);
    } else {
      fetchedMangas[index] = manga;
    }
    _fetchedMangaSubject.add(fetchedMangas);
  }

  @override
  Manga? getFavoriteFromId(String id) =>
      _favoriteMangaSubject.value.firstWhereOrNull((e) => e.id == id);

  @override
  Manga? getMangaFromId(String id) =>
      _fetchedMangaSubject.value.firstWhereOrNull((e) => e.id == id);

  @override
  Future<Result<String, Object>> exportCollection() async {
    try {
      final localMangas = await _localDataSource.getAllMangas();
      final jsonData = jsonEncode(localMangas.map((e) => e.toJson()).toList());
      final formattedDate =
          DateFormat('yyyy-MM-dd-HH-mm-ss').format(DateTime.now());
      final value = await _fileManager.writeFile(
        data: jsonData,
        fileName: 'collection-$formattedDate.json',
      );
      return Result.value(value);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool, Object>> importCollection() async {
    try {
      final fileData = await _fileImport.pickFile();
      if (fileData != null) {
        final parsedData =
            (jsonDecode(fileData) as Iterable).cast<Map<String, dynamic>>();
        final mangas = parsedData.map(MangaKitsuModel.fromJson).toList();
        await _localDataSource.saveAllMangas(mangas);
        return const Result.value(true);
      }
      return const Result.value(false);
    } catch (e) {
      debugPrint(e.toString());
      return Result.error(e);
    }
  }

  @override
  void disposeFavorites() => _favoriteMangaSubject.close();

  @override
  void disposeSearchResults() => _fetchedMangaSubject.close();
}

final mangaRepositoryProvider = Provider<MangaRepository>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  final localDataSource = ref.watch(localDataSourceProvider);
  final fileImport = ref.watch(fileImportProvider);
  final fileManager = ref.watch(fileManagerProvider);

  return MangaRepositoryImpl(
    networkInfo: networkInfo,
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    fileManager: fileManager,
    fileImport: fileImport,
  );
});

final favoriteChangeProvider = StreamProvider.autoDispose<List<Manga>>((ref) {
  final repository = ref.watch(mangaRepositoryProvider);
  ref.onDispose(repository.disposeFavorites);
  return repository.watchFavorites();
});

final resultsChangeProvider = StreamProvider.autoDispose<List<Manga>>((ref) {
  final repository = ref.watch(mangaRepositoryProvider);
  ref.onDispose(repository.disposeSearchResults);
  return repository.watchSearchResults();
});
