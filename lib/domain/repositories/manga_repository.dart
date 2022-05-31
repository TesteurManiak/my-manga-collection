import '../entities/manga.dart';
import '../entities/result.dart';

abstract class MangaRepository {
  Future<Result<List<Manga>, Object>> searchMangas(String title);
  Future<Result<void, Object>> addMangaToFavorite(Manga manga);
  Future<Result<void, Object>> removeMangaFromFavorite(Manga manga);
  Future<Result<void, Object>> editManga(Manga newManga);
  Stream<List<Manga>> watchFavorites();
  Future<List<Manga>> fetchFavorites();
  Manga? getFavoriteFromId(String id);
  Manga? getMangaFromId(String id);
  Future<Result<String, Object>> exportCollection();
}
