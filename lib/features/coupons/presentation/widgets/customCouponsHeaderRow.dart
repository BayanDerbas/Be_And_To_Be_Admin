import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomCouponsHeaderRow extends StatelessWidget {
  const CustomCouponsHeaderRow({super.key});

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
                "الكود",
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                ),
                textAlign: TextAlign.center
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text("القيمة", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text("الحد الأدنى", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text("الصلاحية", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text("الحالة", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text("الفرع", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text("حذف", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
