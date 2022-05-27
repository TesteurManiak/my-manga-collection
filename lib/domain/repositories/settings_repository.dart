import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<ThemeMode?> fetchThemeMode();
}
