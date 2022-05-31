import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';
import '../../controllers/manga/manga_controller.dart';
import 'widgets/manga_content.dart';
import 'widgets/manga_header.dart';
import 'widgets/selection_tile.dart';

class MangaView extends ConsumerWidget {
  final String id;

  const MangaView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(mangaControllerProvider(id));
    final controller = ref.read(mangaControllerProvider(id).notifier);

    final isFavorite = pageState.isFavorite;
    final currentManga = controller.getMangaFromId(id);
    final volumeCount = currentManga.volumeCount;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
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
                    controller.removeFromFavorite(currentManga);
                  } else {
                    controller.addToFavorite(currentManga);
                  }
                },
              ),
            ],
          ),
          SliverToBoxAdapter(child: MangaHeader(manga: currentManga)),
          SliverToBoxAdapter(
            child: MangaContent(
              title: currentManga.title,
              synopsis: currentManga.synopsis,
              volumeCount: volumeCount,
            ),
          ),
          if (isFavorite && volumeCount != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => SelectionTile(
                    volumeNumber: index + 1,
                    manga: currentManga,
                    controller: controller,
                  ),
                  childCount: volumeCount,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
