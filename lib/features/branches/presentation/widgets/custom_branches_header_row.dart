import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CustomBranchesHeaderRow extends StatelessWidget {
  const CustomBranchesHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.smooky2,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: const [
          Expanded(
            flex: 4,
            child: Text(
              "اسم الفرع",
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "أرقام الهواتف",
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "صورة الفرع",
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
