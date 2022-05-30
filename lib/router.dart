import 'package:go_router/go_router.dart';

import 'domain/entities/manga.dart';
import 'presentation/views/edit/edit_view.dart';
import 'presentation/views/home/home_view.dart';
import 'presentation/views/manga/manga_view.dart';

GoRouter routerGenerator({String? initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation ?? AppRoute.home.path,
    routes: [
      GoRoute(
        path: AppRoute.root.path,
        redirect: (_) => AppRoute.home.path,
      ),
      GoRoute(
        name: AppRoute.home.name,
        path: AppRoute.home.path,
        builder: (_, __) => const HomeView(),
        routes: [
          GoRoute(
            name: AppRoute.manga.name,
            path: AppRoute.manga.path,
            builder: (_, state) => MangaView(manga: state.extra as Manga),
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
  manga('manga'),
  edit('edit/:id');

  final String path;

  const AppRoute(this.path);
}
