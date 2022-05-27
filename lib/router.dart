import 'package:go_router/go_router.dart';

import 'domain/entities/manga.dart';
import 'presentation/manga/manga_view.dart';
import 'presentation/views/home/home_view.dart';

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
          ),
        ],
      ),
    ],
  );
}

enum AppRoute {
  root('/'),
  home('/home'),
  manga('manga');

  final String path;

  const AppRoute(this.path);
}
