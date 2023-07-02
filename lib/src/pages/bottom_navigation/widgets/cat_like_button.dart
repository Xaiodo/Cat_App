import 'package:flutter/material.dart';

class CatLikeButton extends StatefulWidget {
  const CatLikeButton({Key? key, required this.isLiked, required this.onTap})
      : super(key: key);

  final bool isLiked;
  final VoidCallback onTap;

  @override
  _CatLikeButtonState createState() => _CatLikeButtonState();
}

class _CatLikeButtonState extends State<CatLikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _animateButton();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(
              widget.isLiked ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }

  void _animateButton() async {
    await _animationController.forward();
    await _animationController.reverse();
  }
}
