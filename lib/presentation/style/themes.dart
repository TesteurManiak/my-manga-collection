import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppTheme {
  static final _baseLight = ThemeData.light();
  static final _baseDark = ThemeData.dark();

  static ThemeData get light {
    const themeColors = AppColors.light();
    return _baseLight.copyWith(
      brightness: Brightness.light,
      primaryColor: themeColors.primary,
      buttonTheme: _baseLight.buttonTheme.copyWith(
        textTheme: ButtonTextTheme.primary,
      ),
      scaffoldBackgroundColor: themeColors.background,
      cardColor: themeColors.background,
      backgroundColor: themeColors.background,
      extensions: {themeColors},
      appBarTheme: _baseLight.appBarTheme.copyWith(
        backgroundColor: themeColors.primary,
      ),
    );
  }

  static ThemeData get dark {
    const themeColors = AppColors.dark();
    return _baseDark.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: themeColors.background,
      cardColor: themeColors.background,
      backgroundColor: themeColors.background,
      chipTheme: _baseDark.chipTheme.copyWith(
        secondarySelectedColor: themeColors.chipSelection,
      ),
      extensions: {themeColors},
      appBarTheme: _baseDark.appBarTheme.copyWith(
        backgroundColor: themeColors.primary,
      ),
    );
  }
}
