import 'package:cat_app/src/navigation/app_router.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/repositories/cat_repository.dart';
import 'package:cat_app/src/providers/dependencies_proiver.dart';
import 'package:cat_app/src/repositories/auth_repository.dart';
import 'package:cat_app/src/values/theme.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../src/pages/bottom_navigation/pages/cat_cubit/cat_cubit.dart';
import '../app_bloc/app_bloc.dart';

class CatAppView extends StatelessWidget {
  const CatAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return DependenciesProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AppBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => CatCubit(
              connectivity: context.read<Connectivity>(),
              repository: context.read<CatRepository>(),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'Cat App',
            theme: theme,
            routerConfig:
                AppRouter(appBloc: context.read<AppBloc>()).routerConfig,
          );
        }),
      ),
    );
  }
}
