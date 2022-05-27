import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SyncLocalDataSource {
  Future<void> initialize();
  Future<bool> setString({required String key, required String value});
  String? getString(String key);
}

class SharedPreferencesLocalDataSource implements SyncLocalDataSource {
  SharedPreferencesLocalDataSource();

  late final SharedPreferences _sharedPreferences;

  @override
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  String? getString(String key) => _sharedPreferences.getString(key);

  @override
  Future<bool> setString({required String key, required String value}) {
    return _sharedPreferences.setString(key, value);
  }
}

final syncLocalDataSourceProvider = Provider<SyncLocalDataSource>((_) {
  return SharedPreferencesLocalDataSource();
});
