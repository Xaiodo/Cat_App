import 'package:cat_app/src/values/app_colors.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
);

const textTheme = TextTheme(
  titleMedium: TextStyle(
    color: AppColors.black,
    fontSize: 18,
  ),
  titleLarge: TextStyle(
    color: AppColors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
);
