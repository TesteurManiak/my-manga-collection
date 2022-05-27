import 'package:go_router/go_router.dart';

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
      ),
    ],
  );
}

enum AppRoute {
  root('/'),
  home('/home');

  final String path;

  const AppRoute(this.path);
}
