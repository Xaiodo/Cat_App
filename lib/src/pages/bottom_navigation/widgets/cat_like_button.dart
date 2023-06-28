import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/cat_cubit/cat_cubit.dart';

class CatLikeButton extends StatelessWidget {
  const CatLikeButton({super.key, required this.isLiked, required this.id});
  final String id;
  final bool isLiked;

  @override
  Widget build(BuildContext context) => InkWell(
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onTap: () => context.read<CatCubit>().likeCat(id),
      );
}
