import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/manga.dart';
import '../../../router.dart';
import 'custom_spinner.dart';

class MangaTile extends StatelessWidget {
  final Manga manga;

  /// Index of the current page on the `HomeView`.
  ///
  /// This is needed for go_router navigation.
  final int index;

  const MangaTile({
    Key? key,
    required this.manga,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final volumeCount = manga.volumeCount;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: CachedNetworkImage(
          imageUrl: manga.posterImage.smallestImageUrl,
          placeholder: (_, __) => const CustomSpinner(),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
      ),
      title: Text(manga.title),
      subtitle: volumeCount != null && volumeCount > 0
          ? Text(
              tr(
                'mangaView.owned',
                args: [
                  manga.volumeOwned.length.toString(),
                  volumeCount.toString()
                ],
              ),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => context.pushNamed(
        AppRoute.manga.name,
        params: {
          'index': index.toString(),
          'id': manga.id,
        },
      ),
    );
  }
}
