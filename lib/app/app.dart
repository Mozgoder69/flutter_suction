import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'theme.dart';
import '../features/workbench/presentation/workbench_page.dart';
import '../features/content_viewer/presentation/viewer_page.dart';
import '../features/settings/presentation/settings_page.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'workbench',
      builder: (c, s) => const WorkbenchPage(),
      routes: [
        // Маршрут Viewer остаётся для мобильного режима.
        GoRoute(
          path: 'viewer',
          name: 'viewer',
          builder: (c, s) {
            final paths = (s.extra as List<String>?) ?? const <String>[];
            return ViewerPage(selectedPaths: paths);
          },
        ),
        GoRoute(
          path: 'settings',
          name: 'settings',
          builder: (c, s) => const SettingsPage(),
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Suction',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      routerConfig: _router,
    );
  }
}
