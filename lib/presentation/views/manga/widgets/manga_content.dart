import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../style/text_styles.dart';
import '../../common/responsive_layout.dart';

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
    final isMobile = ResponsiveLayout.isMobile(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: isMobile ? 16 : size.width / 4,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: appTextStyles?.mangaTitle,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
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
