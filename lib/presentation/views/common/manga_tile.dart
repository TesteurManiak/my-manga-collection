import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/go_router_extensions.dart';
import '../../../domain/entities/manga.dart';
import '../../../router.dart';

class MangaTile extends StatelessWidget {
  final Manga manga;

  const MangaTile({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final volumeCount = manga.volumeCount;
    final location = GoRouter.of(context).locationUri;

    debugPrint("LOCATION: $location");

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
          'index': location.pathSegments[1],
          'id': manga.id,
        },
      ),
    );
  }
}
