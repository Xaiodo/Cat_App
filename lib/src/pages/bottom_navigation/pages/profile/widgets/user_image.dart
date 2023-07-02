import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_app/src/values/app_colors.dart';
import 'package:cat_app/src/values/app_constants.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: AppColors.lightBlue,
          child: url != ''
              ? CachedNetworkImage(imageUrl: url!)
              : Image.asset(
                  Strings.userNoImagePath,
                  width: 100,
                  height: 120,
                  fit: BoxFit.fill,
                ),
        ),
      );
}
