import 'package:go_router/go_router.dart';

import 'presentation/views/home/home_view.dart';

GoRouter routerGenerator({String? initialLocation}) {
  return GoRouter(
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
          final index = int.parse(state.params['index'] as String);
          return HomeView(key: state.pageKey, index: index);
        },
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
