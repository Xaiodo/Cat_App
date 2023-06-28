import 'package:flutter/material.dart';

class CatLikeButton extends StatelessWidget {
  const CatLikeButton({super.key, required this.isLiked, this.onTap});
  final bool isLiked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
      );
}
