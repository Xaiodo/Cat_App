import 'package:cat_app/src/models/user_model.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat.dart';
import 'package:cat_app/src/repositories/cats_repository/cats_repository.dart';
import 'package:cat_app/src/services/cats_services/cat_facts_service.dart';
import 'package:cat_app/src/services/cats_services/cats_local_service.dart';
import 'package:cat_app/src/services/auth_services/auth_local_service.dart';
import 'package:cat_app/src/services/auth_services/auth_service.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../dao/auth_dao.dart';
import '../services/cats_services/cat_images_service.dart';
import '../repositories/auth_repository/auth_repository.dart';

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
            create: (context) => AuthLocalService(
              box: Hive.box<UserModel>(Strings.userBox),
            ),
          ),
          RepositoryProvider(
            create: (context) => AuthDao(
              storage: context.read<FlutterSecureStorage>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => AuthRepository(
              authService: context.read<AuthService>(),
              authDao: context.read<AuthDao>(),
              authLocalService: context.read<AuthLocalService>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => CatFactsService(
              dio: context.read<Dio>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => CatImagesService(
              dio: context.read<Dio>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => CatLocalService(
              box: Hive.box<Cat>(Strings.catBox),
            ),
          ),
          RepositoryProvider(
            create: (context) => CatsRepository(
              catLocalService: context.read<CatLocalService>(),
              catImageService: context.read<CatImagesService>(),
              catFactService: context.read<CatFactsService>(),
            ),
          )
        ],
        child: child,
      );
}
