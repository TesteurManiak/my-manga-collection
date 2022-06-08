import 'package:flutter/material.dart';

import '../../../domain/entities/manga.dart';
import 'manga_grid.dart';
import 'responsive_layout.dart';

class MangaList extends StatelessWidget {
  final List<Manga> mangas;

  /// Index of the current page on the `HomeView`.
  ///
  /// This is needed for go_router navigation.
  final int index;

  const MangaList(this.mangas, {Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (_, __) => MangaGrid(
        mangas: mangas,
        crossAxisCount: 2,
        index: index,
      ),
      tablet: (_, __) => MangaGrid(
        mangas: mangas,
        crossAxisCount: 5,
        index: index,
      ),
      desktop: (_, __) => MangaGrid(mangas: mangas, index: index),
    );
  }
}
