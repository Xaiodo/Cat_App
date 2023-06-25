import 'package:cat_app/src/navigation/app_router.dart';
import 'package:cat_app/src/providers/dependencies_proiver.dart';
import 'package:cat_app/src/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../app_bloc/app_bloc.dart';

class CatAppView extends StatelessWidget {
  const CatAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return DependenciesProvider(
      child: BlocProvider(
        create: (context) =>
            AppBloc(authRepository: context.read<AuthRepository>()),
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'Cat App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig:
                AppRouter(appBloc: context.read<AppBloc>()).routerConfig,
          );
        }),
      ),
    );
  }
}
