import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AddCouponButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddCouponButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'إضافة كوبون',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
