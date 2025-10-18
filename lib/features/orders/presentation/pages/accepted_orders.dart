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

class AcceptedOrdersPage extends StatefulWidget {
  const AcceptedOrdersPage({super.key});
  @override
  State<AcceptedOrdersPage> createState() => _AcceptedOrdersPageState();
}

class _AcceptedOrdersPageState extends State<AcceptedOrdersPage> {
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
    context.read<OrdersCubit>().fetchAcceptedAllOrders();
    context.read<BranchCubit>().fetchBranches();
  }

  @override
  Widget build(BuildContext context) {
    final rc = ResponsiveConfig.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.smooky,
        title: const Text('إدارة الطلبات', style: TextStyle(color: AppColors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: rc.isDesktop ? 32 : 12, vertical: 12),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = ResponsiveConfig.of(context).isMobile;

                return Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment:
                  isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Label
                    const Text(
                      ': نوع الطلب',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),

                    SizedBox(width: isMobile ? 0 : 8, height: isMobile ? 8 : 0),
                    Container(
                      width: isMobile ? double.infinity : 100,
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.smooky2,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.amber, width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selected,
                          dropdownColor: AppColors.smooky2,
                          style: const TextStyle(color: AppColors.white),
                          iconEnabledColor: AppColors.amber,
                          isExpanded: true,
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
                    ),

                    SizedBox(width: isMobile ? 0 : 12, height: isMobile ? 8 : 0),
                    SizedBox(
                      height: 36,
                      width: isMobile ? double.infinity : null,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            context.read<OrdersCubit>().fetchAcceptedAllOrders(),
                        icon: const Icon(Icons.refresh, size: 18),
                        label: isMobile ? const Text('تحديث',style: TextStyle(fontSize: 12),) : const Text('تحديث',style: TextStyle(fontSize: 12),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amber,
                          foregroundColor: AppColors.smooky2,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
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
                                onRefresh: () => context.read<OrdersCubit>().fetchAcceptedAllOrders(),
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
                                  onRefresh: () => context.read<OrdersCubit>().fetchAcceptedAllOrders(),
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
