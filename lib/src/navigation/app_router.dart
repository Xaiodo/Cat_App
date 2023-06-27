import 'dart:async';

import 'package:cat_app/app/app_bloc/app_bloc.dart';
import 'package:cat_app/src/pages/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../pages/bottom_navigation/pages/cat_detailed_view.dart';
import '../pages/bottom_navigation/view/bottom_navigation_view.dart';

class AppRouter {
  AppRouter({required AppBloc appBloc}) : _appBloc = appBloc;

  final AppBloc _appBloc;

  late final GoRouter routerConfig = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) =>
            const MaterialPage(child: BottomNavigationView()),
      ),
      GoRoute(
        path: '/cat_details',
        name: 'cat_details',
        pageBuilder: (context, state) =>
            const MaterialPage(child: CatDetailedView()),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => const MaterialPage(child: LoginView()),
      ),
    ],
    redirect: (context, state) {
      final loggedIn = context.read<AppBloc>().state is AppAuthenticated;
      final isLoginLocation = state.location == '/login';
      if (isLoginLocation && loggedIn) {
        return '/';
      }
      if (!isLoginLocation && !loggedIn) {
        return '/login';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(_appBloc.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
