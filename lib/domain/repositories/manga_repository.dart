import '../entities/manga.dart';
import '../entities/result.dart';

abstract class MangaRepository {
  Future<Result<List<Manga>, Object>> searchMangas(String title);
  Future<void> addMangaToFavorite(Manga manga);
  Future<void> removeMangaFromFavorite(Manga manga);
  Stream<List<Manga>> watchFavorites();
  Future<List<Manga>> fetchFavorites();
}
