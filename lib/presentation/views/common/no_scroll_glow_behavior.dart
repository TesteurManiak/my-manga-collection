import 'package:flutter/material.dart';

class NoScrollGlowBehavior extends ScrollBehavior {
  const NoScrollGlowBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
