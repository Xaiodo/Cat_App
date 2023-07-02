import 'package:cat_app/src/values/app_colors.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
  appBarTheme: appBarTheme,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  splashFactory: NoSplash.splashFactory,
  navigationBarTheme: navigationBarTheme,
);

const appBarTheme = AppBarTheme(
  backgroundColor: AppColors.backgroundColor,
  elevation: 0,
  iconTheme: IconThemeData(
    color: AppColors.black,
  ),
  centerTitle: false,
);

const navigationBarTheme = NavigationBarThemeData(
  labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  height: 60,
  elevation: 0,
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
