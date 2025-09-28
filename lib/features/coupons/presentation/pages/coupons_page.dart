import 'package:be_and_to_be_admin/config/animations/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart' as di;
import '../../domain/entities/get_coupons/coupon_entity.dart';
import '../cubits/addCoupon/add_coupon_cubit.dart';
import '../cubits/get_coupons/get_coupons_cubit.dart';
import '../dialogs/coupon_action_dialogs.dart';
import '../dialogs/add_coupon_dialog.dart';
import '../widgets/customCouponsHeaderRow.dart';
import '../widgets/customCouponsTile.dart';
import '../widgets/custom_add_coupon_button.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<GetCouponsCubit>()..getCoupons()),
        BlocProvider(create: (_) => di.sl<AddCouponCubit>()),
      ],
      child: BlocListener<AddCouponCubit, AddCouponState>(
        listener: (context, state) {
          if (state is AddCouponSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('✅ تم إضافة الكوبون بنجاح: ${state.message}'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
            context.read<GetCouponsCubit>().getCoupons();
          } else if (state is AddCouponFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('❌ فشل إضافة الكوبون: ${state.message}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.black2,
          appBar: AppBar(
            backgroundColor: AppColors.smooky,
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'الكوبونات',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 15, bottom: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AddCouponButton(
                    onPressed: () => showAddCouponDialog(context),
                  ),
                ),
              ),
              const CustomCouponsHeaderRow(),
              Expanded(
                child: BlocBuilder<GetCouponsCubit, GetCouponsState>(
                  builder: (context, state) {
                    if (state is GetCouponsLoading) {
                      return Center(child: LoadinDount());
                    } else if (state is GetCouponsFailure) {
                      return Center(
                        child: Text(
                          "❌ فشل تحميل الكوبونات: ${state.message}",
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else if (state is GetCouponsSuccess) {
                      final List<CouponEntity> coupons = state.coupons.coupons;
                      if (coupons.isEmpty) {
                        return const Center(child: Text('لا توجد كوبونات متاحة.', style: TextStyle(color: AppColors.white)));
                      }
                      return ListView.builder(
                        itemCount: coupons.length,
                        itemBuilder: (context, index) {
                          final coupon = coupons[index];
                          final status = coupon.isActive == 1 ? 'Active' : 'Inactive';
                          final code = coupon.code ?? 'N/A';
                          final value = coupon.value ?? '0';
                          final minOrder = coupon.minOrder ?? '0';
                          final expiresAt = coupon.expiresAt?.split(' ')[0] ?? 'N/A';

                          return CustomCouponsTile(
                            code: code,
                            value: value,
                            min_order: minOrder,
                            expires_at: expiresAt,
                            status: status,
                            branch_name: coupon.branch?.branchName ?? 'الكل',

                            onEditPressed:
                                () => showCouponActionDialog(
                              context,
                              'تعديل الكوبون',
                              'هنا سيظهر نموذج لتعديل الكوبون $code تحديداً.',
                              AppColors.amber,
                              code,
                            ),
                            onDeletePressed:
                                () => showCouponActionDialog(
                              context,
                              'تأكيد الحذف',
                              'هل أنت متأكد من حذف الكوبون $code؟',
                              Colors.red,
                              code,
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}