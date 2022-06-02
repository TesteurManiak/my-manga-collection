import 'package:flutter/material.dart';

import '../../../domain/entities/manga.dart';
import 'manga_tile.dart';

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
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: (_, i) => MangaTile(manga: mangas[i], index: index),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: mangas.length,
    );
  }
}
