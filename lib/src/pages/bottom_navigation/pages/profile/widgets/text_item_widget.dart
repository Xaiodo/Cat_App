import 'package:flutter/material.dart';

import '../../../../../values/app_colors.dart';

class TextItemWidget extends StatelessWidget {
  const TextItemWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
}
