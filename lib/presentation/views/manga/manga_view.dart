import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

import '../../controllers/manga/manga_controller.dart';
import '../common/responsive_layout.dart';
import 'widgets/edit_button.dart';
import 'widgets/manga_content.dart';
import 'widgets/manga_header.dart';
import 'widgets/selection_tile.dart';

class MangaView extends ConsumerWidget {
  final String id;
  final int index;

  const MangaView({Key? key, required this.id, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mangaControllerProvider);
    final controller = ref.read(mangaControllerProvider.notifier);

    final currentManga = controller.getMangaFromId(id);
    final isFavorite = controller.isMangaFavorite(currentManga);
    final volumeCount = currentManga.volumeCount;

    final iconSize = AppBarTheme.of(context).actionsIconTheme?.size ?? 28.0;
    final isMobile = ResponsiveLayout.isMobile(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: isDesktop && isFavorite
          ? EditButton.floating(isFavorite: isFavorite, id: id, index: index)
          : null,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            actions: [
              if (!isDesktop)
                EditButton(isFavorite: isFavorite, id: id, index: index),
              LikeButton(
                size: iconSize,
                isLiked: isFavorite,
                onTap: (_) => controller.toggleFavorite(currentManga),
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
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: isMobile ? 16 : size.width / 6,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  crossAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, index) => SelectionTile(
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
