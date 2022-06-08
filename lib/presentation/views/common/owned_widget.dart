import 'dart:math' as math;

import 'package:flutter/material.dart';

class OwnedWidget extends StatelessWidget {
  final int owned;
  final int? total;

  const OwnedWidget({Key? key, required this.owned, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          total == null || total == 0 ? '?' : '$owned/$total',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(width: 4),
        Transform.rotate(
          angle: math.pi / 14,
          child: const Icon(Icons.book, color: Colors.white),
        ),
      ],
    );
  }
}
