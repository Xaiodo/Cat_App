import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/cat_item_widget.dart';
import '../cat_cubit/cat_cubit.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CatCubit, CatState>(
        builder: (context, state) {
          final favoriteCats = context.read<CatCubit>().favoriteCats;
          if (favoriteCats.isEmpty) {
            return const Center(
              child: Text('No favorite cats. Try to add some'),
            );
          }
          if (state is CatLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: favoriteCats.length,
              itemBuilder: (context, index) => CatItemWidget(
                heroTag: '${favoriteCats[index].id}favorite',
                cat: favoriteCats[index],
              ),
              physics: const ClampingScrollPhysics(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
