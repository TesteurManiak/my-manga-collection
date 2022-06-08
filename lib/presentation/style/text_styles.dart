import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle? mangaTitle;
  final TextStyle? cellTitle;
  final TextStyle? ownedCounter;

  const AppTextStyles({
    this.mangaTitle =
        const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    this.cellTitle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.ownedCounter = const TextStyle(fontSize: 16, color: Colors.white),
  });

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? mangaTitle,
    TextStyle? cellTitle,
    TextStyle? ownedCounter,
  }) {
    return AppTextStyles(
      mangaTitle: mangaTitle ?? this.mangaTitle,
      cellTitle: cellTitle ?? this.cellTitle,
      ownedCounter: ownedCounter ?? this.ownedCounter,
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
      cellTitle: TextStyle.lerp(cellTitle, other.cellTitle, t),
      ownedCounter: TextStyle.lerp(ownedCounter, other.ownedCounter, t),
    );
  }
}
