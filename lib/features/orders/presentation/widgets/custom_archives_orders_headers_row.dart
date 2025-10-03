import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';

class CustomArchivedOrdersHeaderRow extends StatelessWidget {
  const CustomArchivedOrdersHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    final rc = ResponsiveConfig.of(context);

    final rowContent = Row(
      children: [
        rc.isMobile
            ? SizedBox(width: 40, child: Center(child: Text('   #', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold))))
            : Flexible(flex: 1, fit: FlexFit.tight, child: Center(child: Text('   #', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)))),
        rc.isMobile ? SizedBox(width: 8) : SizedBox(width: 12),
        rc.isMobile
            ? SizedBox(width: 120, child: Center(child: Text('الزبون', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold))))
            : Flexible(flex: 3, fit: FlexFit.tight, child: Center(child: Text('الزبون', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)))),
        rc.isMobile ? SizedBox(width: 8) : SizedBox(width: 12),
        rc.isMobile
            ? SizedBox(width: 100, child: Center(child: Text('الهاتف', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold))))
            : Flexible(flex: 2, fit: FlexFit.tight, child: Center(child: Text('الهاتف', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)))),
        rc.isMobile ? SizedBox(width: 8) : SizedBox(width: 12),
        rc.isMobile
            ? SizedBox(width: 80, child: Center(child: Text('الكمية', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold))))
            : Flexible(flex: 2, fit: FlexFit.tight, child: Center(child: Text('الكمية', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)))),
        rc.isMobile ? SizedBox(width: 8) : SizedBox(width: 12),
        rc.isMobile
            ? SizedBox(width: 80, child: Center(child: Text('الكلفة', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold))))
            : Flexible(flex: 2, fit: FlexFit.tight, child: Center(child: Text('الكلفة', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)))),
        rc.isMobile ? SizedBox(width: 8) : SizedBox(width: 12),
        rc.isMobile
            ? SizedBox(width: 80, child: Center(child: Text('كوبون', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold))))
            : Flexible(flex: 2, fit: FlexFit.tight, child: Center(child: Text('كوبون', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)))),
        rc.isMobile ? SizedBox(width: 8) : SizedBox(width: 12),
        rc.isMobile
            ? SizedBox(width: 80, child: Center(child: Text('تفاصيل', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold))))
            : Flexible(flex: 1, fit: FlexFit.tight, child: Center(child: Text('تفاصيل', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)))),
      ],
    );

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.smooky,
        borderRadius: BorderRadius.circular(8),
      ),
      child: rc.isMobile ? SingleChildScrollView(scrollDirection: Axis.horizontal, child: rowContent) : rowContent,
    );
  }
}
