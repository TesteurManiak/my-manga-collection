import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle? mangaTitle;

  const AppTextStyles({
    this.mangaTitle =
        const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
  });

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? mangaTitle,
  }) {
    return AppTextStyles(
      mangaTitle: mangaTitle ?? this.mangaTitle,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
    ThemeExtension<AppTextStyles>? other,
    double t,
  ) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      mangaTitle: TextStyle.lerp(mangaTitle, other.mangaTitle, t),
    );
  }
}
