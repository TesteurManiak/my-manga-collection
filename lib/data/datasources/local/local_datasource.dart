import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalDataSource {
  Future<void> initialize();
  Future<List> getAllMangas();
}

class HiveDataSource implements LocalDataSource {
  final HiveInterface _hiveInterface;

  HiveDataSource(this._hiveInterface);

  @override
  Future<void> initialize() async {
    await _hiveInterface.initFlutter();
  }

  @override
  Future<List> getAllMangas() {
    // TODO: implement getAllMangas
    throw UnimplementedError();
  }
}

final hiveProvider = Provider<HiveInterface>((_) => Hive);

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  final hive = ref.watch(hiveProvider);
  return HiveDataSource(hive);
});
