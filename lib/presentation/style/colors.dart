import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? background;
  final Color? primary;
  final Color? chipSelection;
  final Color? fixedBottomNavigationBar;

  const AppColors({
    this.background,
    this.primary,
    this.chipSelection,
    this.fixedBottomNavigationBar,
  });

  const AppColors.light()
      : this(
          primary: const Color(0xFF2196F3),
          background: const Color(0xFFF5F5F5),
          fixedBottomNavigationBar: Colors.blue,
          chipSelection: const Color(0xFF2196F3),
        );

  const AppColors.dark()
      : this(
          background: const Color(0xFF222727),
          chipSelection: const Color(0xFF82ada9),
          fixedBottomNavigationBar: Colors.blue,
        );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? background,
    Color? primary,
    Color? chipSelection,
    Color? fixedBottomNavigationBar,
  }) {
    return AppColors(
      background: background ?? this.background,
      primary: primary ?? this.primary,
      chipSelection: chipSelection ?? this.chipSelection,
      fixedBottomNavigationBar:
          fixedBottomNavigationBar ?? this.fixedBottomNavigationBar,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      background: Color.lerp(background, other.background, t),
      primary: Color.lerp(primary, other.primary, t),
      chipSelection: Color.lerp(chipSelection, other.chipSelection, t),
      fixedBottomNavigationBar: Color.lerp(
        fixedBottomNavigationBar,
        other.fixedBottomNavigationBar,
        t,
      ),
    );
  }
}
