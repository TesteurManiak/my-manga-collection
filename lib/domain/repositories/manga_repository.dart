import '../entities/manga.dart';

abstract class MangaRepository {
  Future<List<Manga>> fetchFavoriteMangas();
  Stream<List<Manga>> watchFavoriteMangas();
}
