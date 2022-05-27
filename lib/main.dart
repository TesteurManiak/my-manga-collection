import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/datasources/local/local_datasource.dart';
import 'data/datasources/local/sync_local_datasource.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  final syncLocalDataSource = container.read(syncLocalDataSourceProvider);
  await syncLocalDataSource.initialize();

  final localDataSource = container.read(localDataSourceProvider);
  await localDataSource.initialize();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
