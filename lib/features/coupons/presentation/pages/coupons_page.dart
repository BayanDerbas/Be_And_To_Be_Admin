import 'package:be_and_to_be_admin/features/coupons/presentation/cubits/delete_coupon/delete_coupon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart' as di;
import '../../domain/entities/get_coupons/coupon_entity.dart';
import '../cubits/addCoupon/add_coupon_cubit.dart';
import '../cubits/editCoupon/edit_coupon_cubit.dart';
import '../cubits/get_coupons/get_coupons_cubit.dart';
import '../dialogs/add_coupon_dialog.dart';
import '../dialogs/coupon_action_dialogs.dart';
import '../widgets/customCouponsHeaderRow.dart';
import '../widgets/customCouponsTile.dart';
import '../widgets/custom_add_coupon_button.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  Future<void> _refreshCoupons(BuildContext context) async {
    await context.read<GetCouponsCubit>().getCoupons();
  }

  @override
  Widget build(BuildContext context) {
    final double contentWidth = ResponsiveConfig.of(context).isMobile
        ? 800
        : ResponsiveConfig.of(context).isTablet
        ? 1000
        : MediaQuery.of(context).size.width * 0.75;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<GetCouponsCubit>()..getCoupons()),
        BlocProvider(create: (_) => di.sl<AddCouponCubit>()),
        BlocProvider(create: (_) => di.sl<EditCouponCubit>()),
        BlocProvider(create: (_) => di.sl<DeleteCouponCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddCouponCubit, AddCouponState>(
            listener: (context, state) {
              if (state is AddCouponSuccess) {
                Navigator.of(context).pop();
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
          ),
          BlocListener<EditCouponCubit, EditCouponState>(
            listener: (context, state) {
              String? successMessage;
              String? failureMessage;

              if (state is EditPercentValueSuccess ||
                  state is EditMinOrderSuccess ||
                  state is EditExpiresDateSuccess) {
                successMessage =
                '✅ تم تعديل الكوبون بنجاح: ${(state as dynamic).message}';
              } else if (state is EditPercentValueFailure ||
                  state is EditMinOrderFailure ||
                  state is EditExpiresDateFailure) {
                failureMessage = '❌ فشل التعديل: ${(state as dynamic).message}';
              }

              if (successMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(successMessage),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
                context.read<GetCouponsCubit>().getCoupons();
              } else if (failureMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(failureMessage),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 4),
                  ),
                );
              }
            },
          ),
          BlocListener<DeleteCouponCubit, DeleteCouponState>(
            listener: (context, state) {
              if (state is DeleteCouponSuccess) {
                // Show snackbar first
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('✅ تم حذف الكوبون بنجاح: ${state.message}'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
                final rootContext = Navigator.of(context, rootNavigator: true).context;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                  rootContext.read<GetCouponsCubit>().getCoupons();
                });
              } else if (state is DeleteCouponFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('❌ فشل حذف الكوبون: ${state.message}'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 4),
                  ),
                );

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                });
              }
            },
          ),
        ],
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
                padding:
                const EdgeInsets.only(top: 15, right: 15, bottom: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AddCouponButton(
                    onPressed: () => showAddCouponDialog(context),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: contentWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomCouponsHeaderRow(),
                        Expanded(
                          child: BlocBuilder<GetCouponsCubit, GetCouponsState>(
                            builder: (context, state) {
                              if (state is GetCouponsLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is GetCouponsFailure) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    return RefreshIndicator(
                                      onRefresh: () => _refreshCoupons(context),
                                      color: AppColors.amber,
                                      backgroundColor: AppColors.smooky,
                                      child: SingleChildScrollView(
                                        physics:
                                        const AlwaysScrollableScrollPhysics(),
                                        child: SizedBox(
                                          height: constraints.maxHeight,
                                          child: Center(
                                            child: Text(
                                              "❌ فشل تحميل الكوبونات: ${state.message}",
                                              style: const TextStyle(
                                                  color: Colors.red),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is GetCouponsSuccess) {
                                final List<CouponEntity> coupons =
                                    state.coupons.coupons;
                                if (coupons.isEmpty) {
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      return RefreshIndicator(
                                        onRefresh: () =>
                                            _refreshCoupons(context),
                                        color: AppColors.amber,
                                        backgroundColor: AppColors.smooky,
                                        child: SingleChildScrollView(
                                          physics:
                                          const AlwaysScrollableScrollPhysics(),
                                          child: SizedBox(
                                            height: constraints.maxHeight,
                                            child: const Center(
                                              child: Text(
                                                'لا توجد كوبونات متاحة.',
                                                style: TextStyle(
                                                    color: AppColors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return RefreshIndicator(
                                  onRefresh: () => _refreshCoupons(context),
                                  color: AppColors.amber,
                                  backgroundColor: AppColors.smooky,
                                  child: ListView.builder(
                                    itemCount: coupons.length,
                                    itemBuilder: (context, index) {
                                      final coupon = coupons[index];
                                      final status = coupon.isActive == 1
                                          ? 'Active'
                                          : 'Inactive';
                                      final code = coupon.code ?? 'N/A';
                                      final value = coupon.value ?? '0';
                                      final minOrder = coupon.minOrder ?? '0';
                                      final expiresAt =
                                          coupon.expiresAt?.split(' ')[0] ??
                                              'N/A';
                                      final couponId = coupon.id;

                                      return CustomCouponsTile(
                                        code: code,
                                        value: value,
                                        min_order: minOrder,
                                        expires_at: expiresAt,
                                        status: status,
                                        branch_name:
                                        coupon.branch?.branchName ?? 'الكل',
                                        onEditPressed: (fieldType) {
                                          showEditCouponDialog(
                                            context,
                                            couponId,
                                            code,
                                            value,
                                            minOrder,
                                            expiresAt,
                                            fieldType,
                                          );
                                        },
                                        onDeletePressed: () {
                                          showCouponActionDialog(
                                            context,
                                            'تأكيد الحذف',
                                            'هل أنت متأكد من حذف الكوبون $code؟',
                                            Colors.white,
                                            code,
                                            couponId,
                                          );
                                        },
                                      );
                                    },
                                  ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}