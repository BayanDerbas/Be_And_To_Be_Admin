import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomCouponsTile extends StatelessWidget {
  final String code;
  final String value;
  final String min_order;
  final String expires_at;
  final String status;
  final String branch_name;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const CustomCouponsTile({
    super.key,
    required this.code,
    required this.value,
    required this.min_order,
    required this.expires_at,
    required this.status,
    required this.branch_name,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  Widget _buildEditableField(String text, VoidCallback onPressed, String unit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (unit.isNotEmpty)
              Text(
                ' $unit',
                style: const TextStyle(color: AppColors.white, fontSize: 13),
              ),
          ],
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.DarkOlive,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.edit, color: AppColors.amber, size: 20),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = status.toLowerCase() == 'active';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.smooky2,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black1.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.grey2,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                code,
                style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: _buildEditableField(value, onEditPressed, '%'),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: _buildEditableField(min_order, onEditPressed, 'ل.س'),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: _buildEditableField(expires_at, onEditPressed, ''),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isActive ? Icons.check_circle_outline : Icons.cancel_outlined,
                  color: isActive ? AppColors.green_ : Colors.red,
                  size: 20,
                ),
                Text(
                  isActive ? 'مفعل' : 'غير مفعل',
                  style: TextStyle(
                    color: isActive ? AppColors.green_ : Colors.red,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              branch_name,
              style: const TextStyle(color: AppColors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onDeletePressed,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
