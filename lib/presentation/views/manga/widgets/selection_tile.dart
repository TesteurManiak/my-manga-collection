import 'package:flutter/material.dart';

import '../../../../domain/entities/manga.dart';
import '../../../controllers/manga/manga_controller.dart';

class SelectionTile extends StatelessWidget {
  final int volumeNumber;
  final Manga manga;
  final MangaController controller;

  const SelectionTile({
    Key? key,
    required this.volumeNumber,
    required this.manga,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    final isSelected = manga.volumeOwned.contains(volumeNumber);

    final chipTheme = ChipTheme.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () async {
          if (isSelected) {
            await controller.updateManga(
              manga.copyWith(
                volumeOwned:
                    manga.volumeOwned.where((v) => v != volumeNumber).toList(),
              ),
            );
          } else {
            await controller.updateManga(
              manga.copyWith(
                volumeOwned: manga.volumeOwned.toSet().union(
                  {volumeNumber},
                ).toList(),
              ),
            );
          }
        },
        borderRadius: borderRadius,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: textTheme.button?.color ?? Colors.black),
            color: isSelected
                ? chipTheme.selectedColor
                : chipTheme.backgroundColor,
          ),
          child: Text('$volumeNumber'),
        ),
      ),
    );
  }
}
