import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';
import '../../controllers/manga/manga_controller.dart';
import '../../style/text_styles.dart';
import 'widgets/chapters_selection.dart';
import 'widgets/manga_header.dart';

class MangaView extends ConsumerWidget {
  final String id;

  const MangaView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(mangaControllerProvider(id));
    final controller = ref.watch(mangaControllerProvider(id).notifier);

    final isFavorite = pageState.isFavorite;
    final currentManga = pageState.manga;
    final volumeCount = currentManga.volumeCount;

    final appTextStyles = Theme.of(context).extension<AppTextStyles>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (isFavorite)
            IconButton(
              onPressed: () => context.pushNamed(
                AppRoute.edit.name,
                params: {'id': id},
              ),
              icon: const Icon(Icons.edit),
            ),
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              if (isFavorite) {
                controller.removeFromFavorite();
              } else {
                controller.addToFavorite();
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          MangaHeader(manga: currentManga),
          const SizedBox(height: 15),
          Text(
            currentManga.title,
            style: appTextStyles?.mangaTitle,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Text(
              pageState.manga.synopsis,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            tr(
              'mangaView.chapters',
              args: [
                volumeCount?.toString() ?? tr('mangaView.unknown'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          if (isFavorite && volumeCount != null)
            ChaptersSelection(manga: currentManga, volumeCount: volumeCount)
        ],
      ),
    );
  }
}
