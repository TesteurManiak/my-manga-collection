import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/manga.dart';
import '../../common/custom_spinner.dart';

class MangaHeader extends StatelessWidget {
  final Manga manga;

  const MangaHeader({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CachedNetworkImage(
            imageUrl: manga.coverImage?.biggestImageUrl ??
                manga.posterImage.biggestImageUrl,
            placeholder: (_, __) => const CustomSpinner(),
            fit: BoxFit.cover,
          ),
        ),
        Align(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: CachedNetworkImage(
              imageUrl: manga.posterImage.smallestImageUrl,
              placeholder: (_, __) => const CustomSpinner(),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
