import 'package:cat_app/app/app_bloc/app_bloc.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/profile/profile_cubit/profile_cubit.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/profile/widgets/text_item_widget.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/profile/widgets/user_image.dart';
import 'package:cat_app/src/repositories/auth_repository/auth_repository.dart';
import 'package:cat_app/src/values/app_colors.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/cat_cubit/cat_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final catCubit = context.watch<CatCubit>();
    return BlocProvider(
      create: (context) => ProfileCubit(
        authRepository: context.read<AuthRepository>(),
        callback: context.read<AppBloc>(),
      ),
      child: Builder(
        builder: (context) => BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial || state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text(Strings.profileAppBarText),
                actions: [
                  IconButton(
                    onPressed: context.read<ProfileCubit>().logout,
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          UserImage(url: state.user.photoUrl),
                          const SizedBox(width: 50),
                          TextItemWidget(
                            title: Strings.allCatsText,
                            value: catCubit.allCatsCount,
                          ),
                          TextItemWidget(
                            title: Strings.likedCatsText,
                            value: catCubit.favoriteCatsCount,
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(state.user.name ?? ''),
                        iconColor: AppColors.grey,
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(state.user.email ?? ''),
                        iconColor: AppColors.grey,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
