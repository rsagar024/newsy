import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsy_app/features/news/presentation/items/category_item.dart';

class CircularCategoryWidget extends StatelessWidget {
  final CategoryItem category;

  const CircularCategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: category.top,
      bottom: category.bottom,
      left: category.left,
      right: category.right,
      child: Container(
        height: category.radius,
        width: category.radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          image: DecorationImage(
            image: CachedNetworkImageProvider(category.image!),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          category.text,
          style: TextStyle(
            fontSize: category.textSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            shadows: const [Shadow(color: Color(0xFF0F0C0C), blurRadius: 10)],
          ),
        ),
      ),
    );
  }
}
