import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/customTextField.dart';
import '../cubits/addCoupon/add_coupon_cubit.dart';
import 'package:intl/intl.dart';

void showAddCouponDialog(BuildContext context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? code;
  String? minOrder;
  String? percentValue;
  String? expiresDate;
  final TextEditingController dateController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.smooky,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: AppColors.amber, width: 1.5),
      ),
      title: const Text(
        'إضافة كوبون جديد',
        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hintText: 'كود الكوبون (مثل: WEEKEND20)',
                onChanged: (value) => code = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كود الكوبون';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: 'الحد الأدنى للطلب',
                keyboardType: TextInputType.number,
                onChanged: (value) => minOrder = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الحد الأدنى مثال : 150';
                  }
                  if (int.tryParse(value) == null) {
                    return 'يجب أن يكون رقماً صحيحاً';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: 'قيمة الخصم (نسبة مئوية) مثال : 50',
                keyboardType: TextInputType.number,
                onChanged: (value) => percentValue = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال قيمة الخصم';
                  }
                  if (int.tryParse(value) == null) {
                    return 'يجب أن يكون رقماً صحيحاً';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: 'تاريخ الانتهاء (YYYY-MM-DD)',
                controller: dateController,
                onTap: () async {
                  FocusScope.of(ctx).requestFocus(FocusNode());

                  final DateTime? pickedDate = await showDatePicker(
                    context: ctx,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: AppColors.amber,
                              onPrimary: AppColors.black2,
                              surface: AppColors.smooky,
                              onSurface: AppColors.white,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.amber,
                              ),
                            ),
                            dialogTheme: DialogThemeData(
                              backgroundColor: AppColors.smooky,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(color: AppColors.amber, width: 1.5),
                              ),
                            )
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    final String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    dateController.text = formattedDate;
                    expiresDate = formattedDate;
                  }
                },
                onChanged: (value) => expiresDate = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال تاريخ الانتهاء';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('إلغاء', style: TextStyle(color: AppColors.white)),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.pop();
              ctx.read<AddCouponCubit>().addCoupon(
                code: code!,
                min_order: int.parse(minOrder!),
                percent_value: int.parse(percentValue!),
                expires_date: expiresDate!,
              );
            }
          },
          child: const Text('إضافة', style: TextStyle(color: AppColors.white)),
        ),
      ],
    ),
  );
}