import 'package:flutter/material.dart';

import '../../../domain/entities/manga.dart';
import 'manga_cell.dart';

class MangaGrid extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
      ),
      itemCount: mangas.length,
      itemBuilder: (_, i) => MangaCell(manga: mangas[i], index: index),
    );
  }
}
