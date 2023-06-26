import 'package:cat_app/app/app_bloc/app_bloc.dart';
import 'package:cat_app/src/pages/login/widgets/login_button.dart';
import 'package:cat_app/src/values/app_colors.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    void showAlertDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('I like Mark Zuckerberg (NOT!)'),
          content: const Text(
            'This feature is not implemented yet. Because I can`t register project in facebook developers console. Mu app package name is the invalid one lol.',
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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              loginCatImagePath,
            ),
            const SizedBox(height: 16),
            Text(
              welcomeText,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            LoginButton(
              image: const AssetImage(googleLogoImagePath),
              text: signInWithGoogleText,
              onPressed: () {
                context.read<AppBloc>().loginWithGoogle();
              },
              color: AppColors.green,
            ),
            const SizedBox(height: 16),
            LoginButton(
              image: const AssetImage(facebookLogoImagePath),
              text: signInWithFacebookText,
              onPressed: () {
                showAlertDialog();
              },
              color: AppColors.lightBlue,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
