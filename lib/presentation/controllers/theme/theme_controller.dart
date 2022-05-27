import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../../domain/repositories/settings_repository.dart';

part 'theme_state.dart';

class ThemeController extends StateNotifier<ThemeState> {
  final SettingsRepository _settingsRepository;

  ThemeController({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(const ThemeState());

  Future<void> initialize() async {
    final fromStorageSuccess = await restoreFromStorage();
    if (!fromStorageSuccess) {
      await setThemeMode(ThemeMode.system);
    }
  }

  Future<bool> restoreFromStorage() async {
    try {
      final storedMode = await _settingsRepository.fetchThemeMode();
      if (storedMode == null) {
        return false;
      }

      debugPrint('State found in storage: ${storedMode.name}');
      state = ThemeState(themeMode: storedMode);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await _settingsRepository.saveThemeMode(themeMode);
  }

  Future<void> switchThemeMode(Brightness systemBrightness) async {
    final ThemeMode newMode;
    switch (state.themeMode) {
      case ThemeMode.system:
        if (systemBrightness == Brightness.dark) {
          newMode = ThemeMode.light;
        } else {
          newMode = ThemeMode.dark;
        }
        break;
      case ThemeMode.light:
        newMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newMode = ThemeMode.light;
        break;
    }
    await setThemeMode(newMode);
  }
}

final themeControllerProvider =
    StateNotifierProvider.autoDispose<ThemeController, ThemeState>(
  (ref) {
    final settingsRepository = ref.watch(settingsRepositoryProvider);
    return ThemeController(settingsRepository: settingsRepository);
  },
);
