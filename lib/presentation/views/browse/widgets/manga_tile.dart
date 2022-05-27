import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/manga.dart';

class MangaTile extends StatelessWidget {
  final Manga manga;

  const MangaTile({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: manga.posterImage.smallestImageUrl,
        placeholder: (_, __) => const CircularProgressIndicator(),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      ),
      title: Text(manga.title),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
