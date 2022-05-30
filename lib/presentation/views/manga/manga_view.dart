import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/manga.dart';
import '../../style/text_styles.dart';
import 'widgets/manga_header.dart';

class MangaView extends ConsumerWidget {
  final Manga manga;

  const MangaView({Key? key, required this.manga}) : super(key: key);

  final isFavorite = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              if (isFavorite) {
                // TODO: remove from favorites
              } else {
                // TODO: add to favorites
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          MangaHeader(manga: manga),
          const SizedBox(height: 15),
          Text(
            manga.title,
            style: appTextStyles?.mangaTitle,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Text(manga.synopsis, textAlign: TextAlign.center),
          ),
          Text(
            tr(
              'mangaView.chapters',
              args: [
                manga.chapterCount?.toString() ?? tr('mangaView.unknown'),
                manga.volumeCount?.toString() ?? tr('mangaView.unknown'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
