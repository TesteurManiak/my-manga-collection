import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/settings_repository.dart';
import '../../presentation/controllers/theme/theme_controller.dart';
import '../datasources/local/sync_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const storageKey = 'themeMode';

  final SyncLocalDataSource _syncLocalDataSource;

  SettingsRepositoryImpl({required SyncLocalDataSource syncLocalDataSource})
      : _syncLocalDataSource = syncLocalDataSource;

  @override
  Future<ThemeMode?> fetchThemeMode() {
    final themeModeName =
        _syncLocalDataSource.getString(storageKey) ?? fallbackThemeMode;
    final themeMode =
        ThemeMode.values.firstWhere((e) => e.name == themeModeName);
    return Future.value(themeMode);
  }

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) {
    return _syncLocalDataSource.setString(
      key: storageKey,
      value: themeMode.name,
    );
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final syncLocalDataSource = ref.watch(syncLocalDataSourceProvider);
  return SettingsRepositoryImpl(syncLocalDataSource: syncLocalDataSource);
});
