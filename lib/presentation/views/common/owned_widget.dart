import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../style/colors.dart';
import '../../style/text_styles.dart';

class OwnedWidget extends StatelessWidget {
  final int owned;
  final int? total;

  const OwnedWidget({Key? key, required this.owned, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTextStyles = theme.extension<AppTextStyles>();
    final appColors = theme.extension<AppColors>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          total == null || total == 0 ? '?' : '$owned/$total',
          style: appTextStyles?.ownedCounter,
        ),
        const SizedBox(width: 4),
        Transform.rotate(
          angle: math.pi / 14,
          child: Icon(Icons.book, color: appColors?.ownedCounter),
        ),
      ],
    );
  }
}
