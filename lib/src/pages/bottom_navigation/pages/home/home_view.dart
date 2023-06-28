import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../values/app_colors.dart';
import '../../widgets/cat_item_widget.dart';
import '../cat_cubit/cat_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<CatCubit, CatState>(
        listener: (context, state) {
          if (state is CatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
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
          if (state.cats.isEmpty) {
            return const Center(
              child: Text('No internet connection = no cats'),
            );
          }
          if (state is CatLoaded || state is CatNoInternet) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.extentAfter == 0) {
                  context.read<CatCubit>().loadMore();
                }
                return false;
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: state.cats.length,
                itemBuilder: (context, index) => CatItemWidget(
                  cat: state.cats[index],
                  heroTag: '${state.cats[index].id}home',
                ),
                physics: const ClampingScrollPhysics(),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
}
