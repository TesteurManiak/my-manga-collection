import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../domain/entities/manga.dart';
import '../../../router.dart';

class MangaTile extends StatelessWidget {
  final Manga manga;

  const MangaTile({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final volumeCount = manga.volumeCount;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: CachedNetworkImage(
          imageUrl: manga.posterImage.smallestImageUrl,
          placeholder: (_, __) => const CircularProgressIndicator(),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
      ),
      title: Text(manga.title),
      subtitle: volumeCount != null && volumeCount > 0
          ? Text(
              'Owned: ${manga.volumeOwned.length}/$volumeCount'.hardcoded,
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () =>
          context.pushNamed(AppRoute.manga.name, params: {'id': manga.id}),
    );
  }
}
