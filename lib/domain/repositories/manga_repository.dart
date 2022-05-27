import '../entities/manga.dart';

abstract class MangaRepository {
  Future<List<Manga>> searchMangas(String title);
}
