import 'package:cat_app/app/app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<AppBloc>().logout();
            },
            child: const Text('Logout'),
          ),
        ),
      );
}
