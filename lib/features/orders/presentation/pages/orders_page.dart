// orders_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/get_all_orders/orders_entity.dart';
import '../cubits/get_all_orders/orders_cubit.dart';
import '../widgets/custom_orders_headers_row.dart';
import '../widgets/custom_orders_tile.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String selected = 'delivery';
  final Map<String, String> labels = {
    'delivery': 'توصيل (Delivery)',
    'table': 'طاولة (Table)',
    'self': 'ذاتية (Self)'
  };

  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().fetchAllOrders();
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
                SizedBox(
                  height: 30,
                  child: ElevatedButton.icon(
                    onPressed: () => context.read<OrdersCubit>().fetchAllOrders(),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: rc.isMobile
                        ? const SizedBox.shrink() // hide label on mobile
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
                            const CustomOrdersHeaderRow(),
                            const SizedBox(height: 8),
                            Column(
                              children: orders
                                  .map((order) => CustomOrdersTile(
                                order: order,
                                onRefresh: () => context.read<OrdersCubit>().fetchAllOrders(),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          const CustomOrdersHeaderRow(),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 24),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return CustomOrdersTile(
                                  order: orders[index],
                                  onRefresh: () => context.read<OrdersCubit>().fetchAllOrders(),
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
