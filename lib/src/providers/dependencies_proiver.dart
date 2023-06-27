import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/repositories/cat_repository.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/services/cat_facts_service.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/services/cat_local_service.dart';
import 'package:cat_app/src/services/auth_service.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../dao/auth_dao.dart';
import '../pages/bottom_navigation/pages/home/services/cat_image_service.dart';
import '../repositories/auth_repository.dart';

class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => Dio()),
          RepositoryProvider(create: (context) => AuthService()),
          RepositoryProvider(create: (context) => const FlutterSecureStorage()),
          RepositoryProvider(create: (context) => Connectivity()),
          RepositoryProvider(
            create: (context) => AuthDao(
              storage: context.read<FlutterSecureStorage>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => AuthRepository(
              authService: context.read<AuthService>(),
              authDao: context.read<AuthDao>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => CatFactsService(
              dio: context.read<Dio>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => CatImageService(
              dio: context.read<Dio>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => CatLocalService(
              box: Hive.box<Cat>(catBox),
            ),
          ),
          RepositoryProvider(
            create: (context) => CatRepository(
              catLocalService: context.read<CatLocalService>(),
              catImageService: context.read<CatImageService>(),
              catFactService: context.read<CatFactsService>(),
            ),
          )
        ],
        child: child,
      );
}
