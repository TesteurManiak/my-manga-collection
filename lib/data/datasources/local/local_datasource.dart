import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/entities/manga.dart';
import '../../../domain/entities/manga_images.dart';

abstract class LocalDataSource {
  Future<void> initialize();
  Future<List<Manga>> getAllMangas();
  Future<List<Manga>> getMangasFromTitle(String title);
  Future<void> saveManga(Manga manga);
  Future<void> removeManga(Manga manga);
  Future<void> dispose();
  Stream<List<Manga>> watchMangas();
}

class HiveDataSource implements LocalDataSource {
  final HiveInterface _hiveInterface;

  HiveDataSource(this._hiveInterface);

  late final Box<Manga> _mangasBox;

  @override
  Future<void> initialize() async {
    await _hiveInterface.initFlutter();

    _hiveInterface.registerAdapter<MangaImages>(MangaImagesAdapter());
    _hiveInterface.registerAdapter<Manga>(MangaAdapter());

    _mangasBox = await _hiveInterface.openBox<Manga>('mangas');
  }

  @override
  Future<List<Manga>> getAllMangas() =>
      Future.value(_mangasBox.values.toList());

  @override
  Future<void> saveManga(Manga manga) {
    return _mangasBox.put(manga.id, manga);
  }

  @override
  Future<List<Manga>> getMangasFromTitle(String title) {
    return Future.value(
      _mangasBox.values
          .where(
            (manga) => manga.title.toLowerCase().contains(title.toLowerCase()),
          )
          .toList(),
    );
  }

  @override
  Stream<List<Manga>> watchMangas() {
    return _mangasBox.watch().map((_) => _mangasBox.values.toList());
  }

  @override
  Future<void> dispose() {
    return _hiveInterface.close();
  }

  @override
  Future<void> removeManga(Manga manga) => _mangasBox.delete(manga.id);
}

final hiveProvider = Provider<HiveInterface>((_) => Hive);

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  final hive = ref.watch(hiveProvider);
  return HiveDataSource(hive);
});
