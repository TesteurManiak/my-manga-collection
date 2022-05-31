import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/manga.dart';
import '../../../controllers/manga/manga_controller.dart';

class ChaptersSelection extends StatelessWidget {
  final int volumeCount;
  final Manga manga;

  const ChaptersSelection({
    Key? key,
    required this.manga,
    required this.volumeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: Wrap(
        spacing: 4,
        children: List<Widget>.generate(
          volumeCount,
          (index) => _SelectionTile(volumeNumber: index + 1, manga: manga),
        ),
      ),
    );
  }
}

class _SelectionTile extends ConsumerWidget {
  final int volumeNumber;
  final Manga manga;

  const _SelectionTile({
    Key? key,
    required this.volumeNumber,
    required this.manga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius = BorderRadius.circular(8);
    final controller = ref.watch(mangaControllerProvider(manga.id).notifier);
    return InkWell(
      onTap: () => controller.updateManga(
        manga.copyWith(
          volumeOwned: manga.volumeOwned.toSet().union(
            {volumeNumber},
          ).toList(),
        ),
      ),
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: Text('$volumeNumber'),
      ),
    );
  }
}
