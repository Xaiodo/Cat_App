import 'package:cat_app/src/pages/bottom_navigation/bottom_navigation_cubit/bottom_navigation_cubit.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/home_view.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/profile/profile_view.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/favorites/favorites_view.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => BottomNavigationCubit(),
        child: Builder(
          builder: (context) =>
              BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
            builder: (context, state) => Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Offstage(
                      offstage: state.page != BottomNavPage.home,
                      child: const Center(child: Home()),
                    ),
                    Offstage(
                      offstage: state.page != BottomNavPage.favorites,
                      child: const Center(child: FavoritesView()),
                    ),
                    Offstage(
                      offstage: state.page != BottomNavPage.profile,
                      child: const Center(child: ProfileView()),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: NavigationBar(
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: homeText,
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_border_outlined),
                    selectedIcon: Icon(Icons.favorite),
                    label: favoritesText,
                  ),
                  NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: profileText),
                ],
                selectedIndex: state.page.index,
                onDestinationSelected: (index) =>
                    context.read<BottomNavigationCubit>().changePage(index),
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
              ),
            ),
          ),
        ),
      );
}
