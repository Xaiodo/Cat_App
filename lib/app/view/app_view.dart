import 'package:cat_app/src/navigation/app_router.dart';
import 'package:cat_app/src/providers/app_multi_bloc_provider.dart';
import 'package:cat_app/src/providers/dependencies_proiver.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:cat_app/src/values/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../app_bloc/app_bloc.dart';

class CatAppView extends StatelessWidget {
  const CatAppView({super.key});

  @override
  Widget build(BuildContext context) => DependenciesProvider(
        child: AppMultiBlocProvider(
          child: Builder(
            builder: (context) => MaterialApp.router(
              title: Strings.appTitleText,
              theme: theme,
              routerConfig:
                  AppRouter(appBloc: context.read<AppBloc>()).routerConfig,
            ),
          ),
        ),
      );
}
