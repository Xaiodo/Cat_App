import 'dart:async';

import 'package:cat_app/app/app_bloc/app_bloc.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat.dart';
import 'package:cat_app/src/pages/login/view/login_view.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../pages/bottom_navigation/pages/cat_details/cat_details_view.dart';
import '../pages/bottom_navigation/view/bottom_navigation_view.dart';

class AppRouter {
  AppRouter({required AppBloc appBloc}) : _appBloc = appBloc;

  final AppBloc _appBloc;

  late final GoRouter routerConfig = GoRouter(
    routes: [
      GoRoute(
        path: Strings.homePath,
        name: Strings.homeName,
        pageBuilder: (context, state) =>
            const MaterialPage(child: BottomNavigationView()),
      ),
      GoRoute(
        path: Strings.catDetailsPath,
        name: Strings.catDetailsName,
        pageBuilder: (context, state) {
          final Cat cat = state.extra as Cat;
          final String heroTag = state.queryParameters['heroTag'] as String;
          return MaterialPage(
            child: CatDetailsView(
              cat: cat,
              heroTag: heroTag,
            ),
          );
        },
      ),
      GoRoute(
        path: Strings.loginPath,
        name: Strings.loginName,
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginView(),
        ),
      ),
    ],
    initialLocation: Strings.homePath,
    redirect: (context, state) {
      final loggedIn = context.read<AppBloc>().state.authEvent.isAuthenticated;
      final isLoginLocation = state.location == Strings.loginPath;
      if (isLoginLocation && loggedIn) {
        return Strings.homePath;
      }
      if (!isLoginLocation && !loggedIn) {
        return Strings.loginPath;
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
