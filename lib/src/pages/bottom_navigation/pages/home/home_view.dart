import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/cat_cubit/cat_cubit.dart';
import '../../../../values/app_colors.dart';
import '../../../../values/app_constants.dart';
import '../../widgets/app_grid_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<CatCubit, CatState>(
        listener: (context, state) {
          if (state is CatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 1),
                backgroundColor: AppColors.primary,
              ),
            );
          }
          if (state is CatNoInternet) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No internet connection'),
                duration: Duration(seconds: 1),
                backgroundColor: AppColors.primary,
              ),
            );
          }
          if (state is CatLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Loading...'),
                duration: Duration(seconds: 1),
                backgroundColor: AppColors.lightBlue,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CatNoInternet && state.cats.isEmpty) {
            return const Center(
              child: Text('No internet connection = no cats'),
            );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.extentAfter == 0) {
                context.read<CatCubit>().loadMore();
              }
              return false;
            },
            child: RefreshIndicator(
              onRefresh: context.read<CatCubit>().refresh,
              child: AppGridView(
                cats: state.cats,
                heroTag: Strings.homeHeroTag,
              ),
            ),
          );
        },
      );
}
