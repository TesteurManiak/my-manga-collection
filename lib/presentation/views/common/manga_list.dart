import 'package:flutter/material.dart';

import '../../../domain/entities/manga.dart';
import 'manga_tile.dart';

class MangaList extends StatelessWidget {
  final List<Manga> mangas;

  const MangaList(this.mangas, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: (_, index) => MangaTile(manga: mangas[index]),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: mangas.length,
    );
  }
}
