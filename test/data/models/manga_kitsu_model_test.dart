import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_manga_collection/data/models/manga_images_kitsu_model.dart';
import 'package:my_manga_collection/data/models/manga_kitsu_model.dart';

import '../../utils/fixture_reader.dart';

void main() {
  group('MangaKitsuModel', () {
    group('fromJson', () {
      const tNaruto = MangaKitsuModel(
        id: '35',
        link: 'https://kitsu.io/api/edge/manga/35',
        synopsis:
            "Before Naruto's birth, a great demon fox had attacked the Hidden Leaf Village. A man known as the 4th Hokage sealed the demon inside the newly born Naruto, causing him to unknowingly grow up detested by his fellow villagers. Despite his lack of talent in many areas of ninjutsu, Naruto strives for only one goal: to gain the title of Hokage, the strongest ninja in his village. Desiring the respect he never received, Naruto works towards his dream with fellow friends Sasuke and Sakura and mentor Kakashi as they go through many trials and battles that come with being a ninja.",
        title: 'Naruto',
        posterImage: MangaImagesKitsuModel(
          tinyUrl: 'https://media.kitsu.io/manga/poster_images/35/tiny.jpg',
          largeUrl: 'https://media.kitsu.io/manga/poster_images/35/large.jpg',
          smallUrl: 'https://media.kitsu.io/manga/poster_images/35/small.jpg',
          mediumUrl: 'https://media.kitsu.io/manga/poster_images/35/medium.jpg',
          originalUrl:
              'https://media.kitsu.io/manga/poster_images/35/original.png',
        ),
        coverImage: MangaImagesKitsuModel(
          tinyUrl: 'https://media.kitsu.io/manga/cover_images/35/tiny.jpg',
          largeUrl: 'https://media.kitsu.io/manga/cover_images/35/large.jpg',
          smallUrl: 'https://media.kitsu.io/manga/cover_images/35/small.jpg',
          originalUrl:
              'https://media.kitsu.io/manga/cover_images/35/original.jpg',
          mediumUrl: null,
        ),
        chapterCount: 700,
        volumeCount: 72,
        volumeOwned: [],
        isFavorite: false,
      );

      test('parse file: naruto.json', () {
        final file = fixture('naruto.json');
        final fileData = jsonDecode(file) as Map<String, dynamic>;

        final model = MangaKitsuModel.fromJson(fileData);

        expect(model, tNaruto);
      });

      test('parse file: all_naruto.json', () {
        final file = fixture('all_naruto.json');
        final fileData =
            ((jsonDecode(file) as Map<String, dynamic>)['data'] as Iterable)
                .cast<Map<String, dynamic>>();

        final models = fileData.map(MangaKitsuModel.fromJson).toList();

        expect(models.first, tNaruto);
      });
    });
  });
}
