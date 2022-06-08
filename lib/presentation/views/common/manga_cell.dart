import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/manga.dart';
import '../../../router.dart';
import 'custom_spinner.dart';
import 'owned_widget.dart';

class MangaCell extends StatelessWidget {
  final Manga manga;

  /// Index of the current page on the `HomeView`.
  ///
  /// This is needed for go_router navigation.
  final int index;

  const MangaCell({Key? key, required this.manga, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(6);

    final posterImage = manga.posterImage;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => context.pushNamed(
          AppRoute.manga.name,
          params: {
            'index': index.toString(),
            'id': manga.id,
          },
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: posterImage.biggestImageUrl,
                placeholder: (_, __) => const CustomSpinner(),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 6,
                left: 6,
                right: 6,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        manga.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: OwnedWidget(
                        owned: manga.volumeOwned.length,
                        total: manga.volumeCount,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
