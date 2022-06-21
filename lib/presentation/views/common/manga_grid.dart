import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/manga.dart';
import '../../controllers/home/home_controller.dart';
import 'manga_cell.dart';
import 'no_scroll_glow_behavior.dart';

class MangaGrid extends ConsumerWidget {
  final List<Manga> mangas;
  final int crossAxisCount;

  /// Index of the current page on the `HomeView`.
  ///
  /// This is needed for go_router navigation.
  final int index;

  const MangaGrid({
    Key? key,
    required this.mangas,
    required this.index,
    this.crossAxisCount = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        ref
            .read(homeControllerProvider.notifier)
            .onScrolled(notification.direction);
        return true;
      },
      child: ScrollConfiguration(
        behavior: const NoScrollGlowBehavior(),
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.72,
          ),
          itemCount: mangas.length,
          itemBuilder: (_, i) => MangaCell(manga: mangas[i], index: index),
        ),
      ),
    );
  }
}
