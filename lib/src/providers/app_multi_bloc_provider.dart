import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app_bloc/app_bloc.dart';
import '../blocs/cat_cubit/cat_cubit.dart';
import '../repositories/cats_repository/cats_repository.dart';
import '../repositories/auth_repository/auth_repository.dart';

class AppMultiBlocProvider extends StatelessWidget {
  const AppMultiBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AppBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => CatCubit(
              connectivity: context.read<Connectivity>(),
              repository: context.read<CatsRepository>(),
            ),
          ),
        ],
        child: child,
      );
}
