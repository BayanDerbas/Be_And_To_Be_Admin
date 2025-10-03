import 'package:be_and_to_be_admin/features/orders/presentation/widgets/custom__accepted_orders_headers_row.dart';
import 'package:be_and_to_be_admin/features/orders/presentation/widgets/custom_accepted_orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:be_and_to_be_admin/features/branches/domain/entities/branch_entity.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../branches/presentation/cubits/get_branches/branch_cubit.dart';
import '../../domain/entities/get_all_orders/orders_entity.dart';
import '../cubits/get_all_orders/orders_cubit.dart';

class ArchiveOrdersPage extends StatefulWidget {
  const ArchiveOrdersPage({super.key});
  @override
  State<ArchiveOrdersPage> createState() => _ArchiveOrdersPageState();
}

class _ArchiveOrdersPageState extends State<ArchiveOrdersPage> {
  String selected = 'delivery';
  final Map<String, String> labels = {
    'delivery': 'توصيل (Delivery)',
    'table': 'طاولة (Table)',
    'self': 'ذاتية (Self)'
  };

  BranchEntity? selectedBranch;

  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().fetchArchivesAllOrders();
    context.read<BranchCubit>().fetchBranches();
  }

  @override
  Widget build(BuildContext context) {
    final rc = ResponsiveConfig.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.smooky,
        title: const Text('الأرشيف', style: TextStyle(color: AppColors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: rc.isDesktop ? 32 : 12, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'نوع الطلب: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: rc.isMobile ? 80 : 90,
                  height: 30,
                  child: DropdownButton<String>(
                    value: selected,
                    dropdownColor: AppColors.smooky,
                    style: const TextStyle(color: AppColors.white),
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: 'delivery', child: Text('توصيل')),
                      DropdownMenuItem(value: 'table', child: Text('طاولة')),
                      DropdownMenuItem(value: 'self', child: Text('ذاتي')),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => selected = v);
                    },
                  ),
                ),
                const Spacer(),
                // BlocBuilder<BranchCubit, BranchState>(
                //   builder: (context, state) {
                //     if (state is BranchLoading) {
                //       return const SizedBox(
                //         height: 24,
                //         width: 24,
                //         child: CircularProgressIndicator(strokeWidth: 2),
                //       );
                //     } else if (state is BranchSuccess) {
                //       final branches = state.branches.branches;
                //
                //       return SizedBox(
                //         width: rc.isMobile ? 120 : 200,
                //         height: 30,
                //         child: DropdownButton<BranchEntity>(
                //           value: selectedBranch,
                //           hint: const Text(
                //             "اختر الفرع",
                //             style: TextStyle(color: AppColors.white),
                //           ),
                //           isExpanded: true,
                //           dropdownColor: AppColors.smooky2,
                //           underline: const SizedBox(),
                //           style: const TextStyle(color: AppColors.white),
                //           items: branches.map((branch) {
                //             return DropdownMenuItem(
                //               value: branch,
                //               child: Align(
                //                 alignment: Alignment.centerRight,
                //                 child: Text(
                //                   branch.branch_name ?? "Unnamed",
                //                   style: const TextStyle(color: AppColors.white),
                //                 ),
                //               ),
                //             );
                //           }).toList(),
                //           onChanged: (branch) {
                //             setState(() {
                //               selectedBranch = branch;
                //             });
                //           },
                //         ),
                //       );
                //     }
                //     return const SizedBox.shrink();
                //   },
                // ),

                const SizedBox(width: 12),
                SizedBox(
                  height: 30,
                  child: ElevatedButton.icon(
                    onPressed: () => context.read<OrdersCubit>().fetchArchivesAllOrders(),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: rc.isMobile
                        ? const SizedBox.shrink()
                        : const Text('تحديث'),
                    style: ElevatedButton.styleFrom(
                      padding: rc.isMobile ? const EdgeInsets.all(6) : null,
                      backgroundColor: AppColors.amber,
                      foregroundColor: AppColors.smooky2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // --- Orders List ---
            Expanded(
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  if (state is OrdersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrdersLoaded) {
                    final orders = (state.orders[selected] ?? []).cast<OrderEntity>();
                    if (orders.isEmpty) {
                      return Center(
                        child: Text(
                          'لا يوجد طلبات لـ ${labels[selected]}',
                          style: const TextStyle(color: AppColors.white),
                        ),
                      );
                    }

                    // --- Mobile: horizontal scroll, Desktop: column ---
                    if (rc.isMobile) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomAcceptedOrdersHeaderRow(),
                            const SizedBox(height: 8),
                            Column(
                              children: orders
                                  .map((order) => CustomAcceptedOrdersTile(
                                order: order,
                                onRefresh: () => context.read<OrdersCubit>().fetchArchivesAllOrders(),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          const CustomAcceptedOrdersHeaderRow(),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 24),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return CustomAcceptedOrdersTile(
                                  order: orders[index],
                                  onRefresh: () => context.read<OrdersCubit>().fetchArchivesAllOrders(),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (state is OrdersError) {
                    return Center(
                      child: Text('خطأ: ${state.message}', style: const TextStyle(color: Colors.red)),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
