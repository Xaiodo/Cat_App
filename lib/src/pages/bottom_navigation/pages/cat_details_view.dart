import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/cat_cubit/cat_cubit.dart';
import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat.dart';
import 'package:cat_app/src/pages/bottom_navigation/widgets/cat_like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatDetailsView extends StatelessWidget {
  const CatDetailsView({
    super.key,
    required this.cat,
    required this.heroTag,
  });

  final Cat cat;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Details'),
        actions: [
          BlocBuilder<CatCubit, CatState>(
            builder: (context, state) {
              return CatLikeButton(
                isLiked: state.cats.firstWhere((c) => c.id == cat.id).isLiked,
                onTap: () => context.read<CatCubit>().likeCat(cat.id),
              );
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: heroTag,
            child: CachedNetworkImage(
              imageUrl: cat.url,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(cat.fact),
          )
        ],
      ),
    );
  }
}
