import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import 'presentation/views/edit/edit_view.dart';
import 'presentation/views/home/home_view.dart';
import 'presentation/views/manga/manga_view.dart';

GoRouter routerGenerator({String? initialLocation}) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: initialLocation ?? '${AppRoute.home.path}/1',
    routes: [
      GoRoute(
        path: AppRoute.root.path,
        redirect: (_) => '${AppRoute.home.path}/1',
      ),
      GoRoute(
        name: AppRoute.home.name,
        path: '${AppRoute.home.path}/:index',
        builder: (_, state) {
          return HomeView(
            key: state.pageKey,
            index: int.parse(state.params['index'] as String),
          );
        },
        routes: [
          GoRoute(
            name: AppRoute.manga.name,
            path: AppRoute.manga.path,
            builder: (_, state) => MangaView(
              id: state.params['id']!,
            ),
            routes: [
              GoRoute(
                name: AppRoute.edit.name,
                path: AppRoute.edit.path,
                builder: (_, state) => EditView(id: state.params['id']!),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

enum AppRoute {
  root('/'),
  home('/home'),
  manga('manga/:id'),
  edit('edit');

  final String path;

  const AppRoute(this.path);
}
