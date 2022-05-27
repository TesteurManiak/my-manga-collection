import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'manga_images.dart';

class Manga extends Equatable {
  final String id;
  final String link;
  final String synopsis;
  final String title;
  final MangaImages posterImage;
  final MangaImages? coverImage;
  final int? chapterCount;
  final int? volumeCount;
  final List<int> volumeOwned;
  final bool isFavorite;

  const Manga({
    required this.id,
    required this.link,
    required this.synopsis,
    required this.title,
    required this.posterImage,
    required this.coverImage,
    required this.chapterCount,
    required this.volumeCount,
    required this.volumeOwned,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [
        id,
        link,
        synopsis,
        title,
        posterImage,
        coverImage,
        chapterCount,
        volumeCount,
        volumeOwned,
        isFavorite,
      ];

  Manga copyWith({
    String? id,
    String? link,
    String? synopsis,
    String? title,
    MangaImages? posterImage,
    MangaImages? coverImage,
    int? chapterCount,
    int? volumeCount,
    List<int>? volumeOwned,
    bool? isFavorite,
  }) {
    return Manga(
      id: id ?? this.id,
      link: link ?? this.link,
      synopsis: synopsis ?? this.synopsis,
      title: title ?? this.title,
      posterImage: posterImage ?? this.posterImage,
      coverImage: coverImage ?? this.coverImage,
      chapterCount: chapterCount ?? this.chapterCount,
      volumeCount: volumeCount ?? this.volumeCount,
      volumeOwned: volumeOwned ?? this.volumeOwned,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'links': {'self': link},
      'attributes': {
        'synopsis': synopsis,
        'canonicalTitle': title,
        if (chapterCount != null) 'chapterCount': chapterCount,
        if (volumeCount != null) 'volumeCount': volumeCount,
        'posterImage': posterImage.toJson(),
        if (coverImage != null) 'coverImage': coverImage?.toJson(),
      },
      'volumeOwned': volumeOwned,
      'isFavorite': isFavorite,
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  String toString() => toRawJson();
}
