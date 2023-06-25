import 'package:cat_app/app/app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: InkWell(
          onTap: context.read<AppBloc>().login,
          child: Center(
            child: const Text('Login View'),
          ),
        ),
      );
}
