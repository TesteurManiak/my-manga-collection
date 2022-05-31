import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../style/text_styles.dart';

class MangaContent extends StatelessWidget {
  final String title;
  final String synopsis;
  final int? volumeCount;

  const MangaContent({
    Key? key,
    required this.title,
    required this.synopsis,
    required this.volumeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Text(
            title,
            style: appTextStyles?.mangaTitle,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Text(synopsis, textAlign: TextAlign.center),
          ),
          Text(
            tr(
              'mangaView.chapters',
              args: [
                volumeCount?.toString() ?? tr('mangaView.unknown'),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
