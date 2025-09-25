import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomCategoriesTile extends StatelessWidget {
  final String name;
  final String image;
  final String branch;

  const CustomCategoriesTile({
    super.key,
    required this.name,
    required this.image,
    required this.branch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.smooky2,
      margin: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: 70,
              alignment: Alignment.center,
              child: image.isNotEmpty
                  ? Image.network(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                  );
                },
              )
                  : const Icon(
                Icons.image_not_supported,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              branch,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
