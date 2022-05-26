import '../../domain/entities/manga_images.dart';

class MangaImagesKitsuModel extends MangaImages {
  const MangaImagesKitsuModel({
    required super.tinyUrl,
    required super.smallUrl,
    required super.mediumUrl,
    required super.largeUrl,
    required super.originalUrl,
  });

  factory MangaImagesKitsuModel.fromJson(Map<String, dynamic> json) {
    return MangaImagesKitsuModel(
      tinyUrl: json['tiny'] as String,
      smallUrl: json['small'] as String,
      mediumUrl: json['medium'] as String,
      largeUrl: json['large'] as String,
      originalUrl: json['original'] as String,
    );
  }
}
