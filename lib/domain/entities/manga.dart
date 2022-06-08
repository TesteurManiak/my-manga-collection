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
  final String synopsis;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final MangaImages posterImage;

  @HiveField(4)
  final MangaImages? coverImage;

  @HiveField(5)
  final int? volumeCount;

  @HiveField(6)
  final List<int> volumeOwned;

  const Manga({
    required this.id,
    required this.synopsis,
    required this.title,
    required this.posterImage,
    required this.coverImage,
    required this.volumeCount,
    required this.volumeOwned,
  });

  @override
  List<Object?> get props => [
        id,
        synopsis,
        title,
        posterImage,
        coverImage,
        volumeCount,
        volumeOwned,
      ];

  Manga copyWith({
    String? id,
    String? synopsis,
    String? title,
    MangaImages? posterImage,
    MangaImages? coverImage,
    int? volumeCount,
    List<int>? volumeOwned,
  }) {
    return Manga(
      id: id ?? this.id,
      synopsis: synopsis ?? this.synopsis,
      title: title ?? this.title,
      posterImage: posterImage ?? this.posterImage,
      coverImage: coverImage ?? this.coverImage,
      volumeCount: volumeCount ?? this.volumeCount,
      volumeOwned: volumeOwned ?? this.volumeOwned,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'attributes': {
        'synopsis': synopsis,
        'canonicalTitle': title,
        if (volumeCount != null) 'volumeCount': volumeCount,
        'posterImage': posterImage.toJson(),
        if (coverImage != null) 'coverImage': coverImage?.toJson(),
      },
      if (volumeOwned.isNotEmpty) 'volumeOwned': volumeOwned,
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  String toString() => toRawJson();
}
