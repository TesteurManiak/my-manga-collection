import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'manga_images.dart';

part 'manga.g.dart';

@HiveType(typeId: 1)
class Manga extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String link;

  @HiveField(2)
  final String synopsis;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final MangaImages posterImage;

  @HiveField(5)
  final MangaImages? coverImage;

  @HiveField(6)
  final int? chapterCount;

  @HiveField(7)
  final int? volumeCount;

  @HiveField(8)
  final List<int> volumeOwned;

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
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  String toString() => toRawJson();
}
