import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomCategoriesHeaderRow extends StatelessWidget {
  const CustomCategoriesHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.smooky2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              "الاسم",
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "الصورة",
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "الفرع",
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
