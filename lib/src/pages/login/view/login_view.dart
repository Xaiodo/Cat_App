import 'package:cat_app/app/app_bloc/app_bloc.dart';
import 'package:cat_app/src/pages/login/widgets/login_button.dart';
import 'package:cat_app/src/values/app_colors.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app_bloc/app_ui_events.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    void showAlertDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(Strings.alertTitleText),
          content: const Text(
            Strings.alertContentText,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.lastEvent != null) {
          final event = state.lastEvent;

          if (event is AppUiEventsShowSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(event.message),
              ),
            );
          }
          state.popEvent(state.lastEvent!);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                Strings.loginCatImagePath,
              ),
              const SizedBox(height: 16),
              Text(
                Strings.welcomeText,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              LoginButton(
                image: const AssetImage(Strings.googleLogoImagePath),
                text: Strings.signInWithGoogleText,
                onPressed: context.read<AppBloc>().loginWithGoogle,
                color: AppColors.green,
              ),
              const SizedBox(height: 16),
              LoginButton(
                image: const AssetImage(Strings.facebookLogoImagePath),
                text: Strings.signInWithFacebookText,
                onPressed: showAlertDialog,
                color: AppColors.lightBlue,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
