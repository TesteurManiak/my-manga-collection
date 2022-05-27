import '../entities/manga.dart';
import '../entities/result.dart';

abstract class MangaRepository {
  Future<Result<List<Manga>, Object>> searchMangas(String title);
}
