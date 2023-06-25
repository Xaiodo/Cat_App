import 'package:cat_app/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../dao/auth_dao.dart';
import '../repositories/auth_repository.dart';

class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(providers: [
        RepositoryProvider(create: (context) => AuthService()),
        RepositoryProvider(create: (context) => const FlutterSecureStorage()),
        RepositoryProvider(
            create: (context) =>
                AuthDao(storage: context.read<FlutterSecureStorage>())),
        RepositoryProvider(
          create: (context) => AuthRepository(
              authService: context.read<AuthService>(),
              authDao: context.read<AuthDao>()),
        ),
      ], child: child);
}
