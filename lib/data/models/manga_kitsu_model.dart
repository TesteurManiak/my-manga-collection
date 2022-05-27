import '../../domain/entities/manga.dart';
import 'manga_images_kitsu_model.dart';

class MangaKitsuModel extends Manga {
  const MangaKitsuModel({
    required super.id,
    required super.link,
    required super.synopsis,
    required super.title,
    required super.posterImage,
    required super.coverImage,
    required super.chapterCount,
    required super.volumeCount,
    required super.volumeOwned,
  });

  factory MangaKitsuModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;
    final title = (attributes['canonicalTitle'] as String)
        .replaceAll(RegExp(r'[^\s\w]'), '');
    return MangaKitsuModel(
      id: json['id'] as String,
      link: json['links']['self'] as String,
      synopsis: attributes['synopsis'] as String,
      title: title,
      posterImage: MangaImagesKitsuModel.fromJson(
        attributes['posterImage'] as Map<String, dynamic>,
      ),
      coverImage: attributes['coverImage'] != null
          ? MangaImagesKitsuModel.fromJson(
              attributes['coverImage'] as Map<String, dynamic>,
            )
          : null,
      chapterCount: attributes['chapterCount'] as int?,
      volumeCount: attributes['volumeCount'] as int?,
      volumeOwned: List<int>.from((json['volumeOwned'] as Iterable?) ?? []),
    );
  }
}
