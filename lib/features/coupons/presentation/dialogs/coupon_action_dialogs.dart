import 'package:be_and_to_be_admin/config/animations/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../cubits/delete_coupon/delete_coupon_cubit.dart';
import '../cubits/editCoupon/edit_coupon_cubit.dart';
import '../cubits/get_coupons/get_coupons_cubit.dart';

Future<void> showEditCouponDialog(
    BuildContext context,
    int couponId,
    String code,
    String value,
    String minOrder,
    String expiresAt,
    String fieldType,
    ) async {
  final TextEditingController controller = TextEditingController();

  if (fieldType == "value") controller.text = value;
  if (fieldType == "min_order") controller.text = minOrder;
  if (fieldType == "expires_at") controller.text = expiresAt;

  await showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: AppColors.smooky,
        title: Text(
          "تعديل الكوبون: $code",
          style: const TextStyle(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
        content: fieldType == "expires_at"
            ? GestureDetector(
          onTap: () async {
            FocusScope.of(ctx).requestFocus(FocusNode());
            final picked = await showDatePicker(
              context: ctx,
              initialDate: DateTime.tryParse(expiresAt) ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2050),
              builder: (context, child) => Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: AppColors.amber,
                    onPrimary: AppColors.black2,
                    surface: AppColors.smooky,
                    onSurface: AppColors.white,
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) {
              controller.text = DateFormat('yyyy-MM-dd').format(picked);
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "تاريخ الانتهاء",
                labelStyle: const TextStyle(color: AppColors.white),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white),
                ),
              ),
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        )
            : TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: fieldType == "value"
                ? "أدخل نسبة الخصم الجديدة (%)"
                : "أدخل الحد الأدنى الجديد (ل.س)",
            labelStyle: const TextStyle(color: AppColors.white),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.amber),
            ),
          ),
          style: const TextStyle(color: AppColors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("إلغاء", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              final input = controller.text.trim();
              if (input.isEmpty) return;

              final cubit = ctx.read<EditCouponCubit>();

              if (fieldType == "value") {
                cubit.editPercentValue(value: int.tryParse(input) ?? 0, coupon_id: couponId);
              } else if (fieldType == "min_order") {
                cubit.editMinOrder(min_order: int.tryParse(input) ?? 0, coupon_id: couponId);
              } else if (fieldType == "expires_at") {
                cubit.editExpiresDate(expires_at: input, coupon_id: couponId);
              }

              context.pop();
            },
            child: const Text("حفظ", style: TextStyle(color: AppColors.white)),
          ),
        ],
      );
    },
  );
}

void showCouponActionDialog(
    BuildContext context,
    String title,
    String content,
    Color titleColor,
    String code,
    int couponId,
    ) {
  showDialog(
    context: context,
    builder: (ctx) => BlocProvider.value(
      value: context.read<DeleteCouponCubit>(),
      child: AlertDialog(
        backgroundColor: AppColors.smooky,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: AppColors.amber, width: 1.5),
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
            onPressed: () => context.pop(),
            child: Text(title == 'تأكيد الحذف' ? 'إلغاء' : 'إغلاق',
                style: const TextStyle(color: AppColors.white)),
          ),
          if (title == 'تأكيد الحذف')
            BlocConsumer<DeleteCouponCubit, DeleteCouponState>(
              listener: (context, state) {
                if (state is DeleteCouponSuccess) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('✅ تم حذف الكوبون: ${state.message}'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  context.read<GetCouponsCubit>().getCoupons();
                } else if (state is DeleteCouponFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('❌ فشل الحذف: ${state.message}'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is DeleteCouponLoading) {
                  return LoadinDount();
                }
                return TextButton(
                  onPressed: () {
                    context.read<DeleteCouponCubit>().deleteCoupon(coupon_id: couponId);
                  },
                  child: const Text('حذف', style: TextStyle(color: Colors.white)),
                );
              },
            ),
        ],
      ),
    ),
  );
}