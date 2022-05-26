import 'package:flutter/painting.dart';

class AppColors {
  final Color background;

  const AppColors({
    required this.background,
  });

  const AppColors.light()
      : this(
          background: const Color(0xFFF5F5F5),
        );

  const AppColors.dark()
      : this(
          background: const Color(0xFF222727),
        );
}
