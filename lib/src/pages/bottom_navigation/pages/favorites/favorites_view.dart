import 'package:cat_app/src/pages/bottom_navigation/widgets/app_grid_view.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/cat_cubit/cat_cubit.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CatCubit, CatState>(
        builder: (context, state) {
          final favoriteCats = context.read<CatCubit>().favoriteCats;
          if (favoriteCats.isEmpty) {
            return const Center(
              child: Text(Strings.noFavoriteCatsText),
            );
          }
          if (state is CatLoaded || state is CatNoInternet) {
            return AppGridView(
              cats: favoriteCats,
              heroTag: Strings.favoriteCatsHeroTag,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
