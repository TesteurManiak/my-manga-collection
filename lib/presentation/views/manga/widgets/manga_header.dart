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
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CachedNetworkImage(
            imageUrl: manga.coverImage?.biggestImageUrl ??
                manga.posterImage.biggestImageUrl,
            placeholder: (_, __) => const CustomSpinner(),
            errorWidget: (_, __, ___) => const SizedBox(),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: CachedNetworkImage(
            imageUrl: manga.posterImage.biggestImageUrl,
            placeholder: (_, __) => const CustomSpinner(),
            errorWidget: (_, __, ___) => const Icon(Icons.error),
            height: size.height / 5,
          ),
        ),
      ],
    );
  }
}
