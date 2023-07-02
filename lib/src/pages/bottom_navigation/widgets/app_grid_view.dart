import 'package:cat_app/src/pages/bottom_navigation/pages/home/model/cat.dart';
import 'package:flutter/material.dart';

import 'cat_item_widget.dart';

class AppGridView extends StatelessWidget {
  const AppGridView({
    super.key,
    required this.cats,
    required this.heroTag,
  });
  final List<Cat> cats;
  final String heroTag;

  @override
  Widget build(BuildContext context) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: cats.length,
        itemBuilder: (context, index) => CatItemWidget(
          heroTag: heroTag + cats[index].id,
          cat: cats[index],
        ),
        physics: const ClampingScrollPhysics(),
      );
}
