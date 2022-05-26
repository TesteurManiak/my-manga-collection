import '../../domain/entities/manga.dart';
import 'manga_images_kitsu_model.dart';

class MangaKitsuModel extends Manga {
  const MangaKitsuModel({
    required super.id,
    required super.link,
    required super.synopsis,
    required super.title,
    required super.images,
    required super.chapterCount,
    required super.volumeCount,
    required super.volumeOwned,
    required super.isFavorite,
  });

  factory MangaKitsuModel.fromJson(Map<String, dynamic> json) {
    final title = (json['attributes']['canonicalTitle'] as String)
        .replaceAll(RegExp(r'[^\s\w]'), '');
    return MangaKitsuModel(
      id: json['id'] as String,
      link: json['links']['self'] as String,
      synopsis: json['attributes']['synopsis'] as String,
      title: title,
      images: MangaImagesKitsuModel.fromJson(
        json['attributes']['posterImage'] as Map<String, dynamic>,
      ),
      chapterCount: json['attributes']['chapterCount'] as int,
      volumeCount: json['attributes']['volumeCount'] as int,
      volumeOwned: List<int>.from((json['volumeOwned'] as Iterable?) ?? []),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
