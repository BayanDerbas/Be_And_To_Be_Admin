import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

void showCouponActionDialog(
    BuildContext context,
    String title,
    String content,
    Color titleColor,
    String code,
    ) {
  showDialog(
    context: context,
    builder:
        (ctx) => AlertDialog(
      backgroundColor: AppColors.smooky,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: AppColors.white, width: 1.5),
      ),
      title: Text(
        '$title: $code',
        style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
      ),
      content: Text(
        content,
        style: const TextStyle(color: AppColors.grey1),
        textAlign: TextAlign.right,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(
            title == 'تأكيد الحذف' ? 'إلغاء' : 'إغلاق',
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        if (title == 'تأكيد الحذف')
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
      ],
    ),
  );
}