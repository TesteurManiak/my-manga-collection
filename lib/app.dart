import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/controllers/theme/theme_controller.dart';
import 'presentation/style/themes.dart';
import 'router.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _router = routerGenerator();

  @override
  Widget build(BuildContext context) {
    // Rebuild on theme change
    final themeMode =
        ref.watch(themeControllerProvider.select((value) => value.themeMode));

    return MaterialApp.router(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
