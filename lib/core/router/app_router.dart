import 'package:digify_app/features/home/presentation/view/home.dart';
import 'package:digify_app/features/services/presentation/view/explore_services_view.dart';
import 'package:digify_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A global key for GoRouter navigation access (optional but handy)
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// GoRouter configuration with ShellRoute and web-like transitions
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  // initialLocation: '/login',
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(path: '/services', builder: (context, state) => const ExploreServicesPage()),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        '404 - Page Not Found',
        style: const TextStyle(color: Colors.white),
      ),
    ),
    backgroundColor: Colors.black,
  ),
);

/// Helper function for fade transition
CustomTransitionPage _fadePage(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
