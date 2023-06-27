import 'package:cat_app/src/pages/bottom_navigation/widgets/cat_like_button.dart';
import 'package:flutter/material.dart';

import '../../../values/app_colors.dart';
import '../pages/home/model/cat.dart';

class CatItemWidget extends StatelessWidget {
  const CatItemWidget({
    Key? key,
    required this.cat,
  }) : super(key: key);

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.redAccent,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    if (loadingProgress.expectedTotalBytes == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!,
                          color: AppColors.green,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.green,
                          ),
                          child: Text(
                            'Loading ${((loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!) * 100).round()}%',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  cat.url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CatLikeButton(isLiked: cat.isLiked, id: cat.id),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cat.fact,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
