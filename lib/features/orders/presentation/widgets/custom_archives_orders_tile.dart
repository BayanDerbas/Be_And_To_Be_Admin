import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/get_all_orders/orders_entity.dart';

class CustomArchivedOrdersTile extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onRefresh;

  const CustomArchivedOrdersTile({
    super.key,
    required this.order,
    required this.onRefresh,
  });

  String _formatPrice(int? value) {
    final f = NumberFormat('#,##0', 'en_US');
    return '${f.format(value ?? 0)} ل.س';
  }

  @override
  Widget build(BuildContext context) {
    final rc = ResponsiveConfig.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.smooky2,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black1.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: rc.isMobile ? _buildMobileRow(context) : _buildDesktopRow(context),
    );
  }

  Widget _buildDesktopRow(BuildContext context) {
    final couponText = order.coupon?.code ?? '-';

    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              '${order.id ?? '-'}',
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              order.user?.fullname ?? '-',
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              order.user?.phonenumber ?? '-',
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              '${order.itemNumber ?? 0}',
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              _formatPrice(order.totalPrice),
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              couponText,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Center(
            child: SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: () => _showDetailsDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.amber,
                ),
                child: const Text(
                  'تفاصيل',
                  style: TextStyle(color: AppColors.smooky2, fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileRow(BuildContext context) {
    final couponText = order.coupon?.code ?? '-';

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            child: Center(
              child: Text(
                '${order.id ?? '-'}',
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: Center(
              child: Text(
                order.user?.fullname ?? '-',
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                order.user?.phonenumber ?? '-',
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                '${order.itemNumber ?? 0}',
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                _formatPrice(order.totalPrice),
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                couponText,
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            height: 36,
            width: 100,
            child:
            ////here fix it design
            ElevatedButton(
              onPressed: () => _showDetailsDialog(context),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.amber),
              child: const Text(
                'تفاصيل',
                style: TextStyle(color: AppColors.smooky2, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
        backgroundColor: AppColors.smooky,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: ResponsiveConfig.of(context).isDesktop ? 800 : 360,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'تفاصيل الطلب${order.id ?? '-'}#',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: AppColors.amber, thickness: 1.2),
                  const SizedBox(height: 12),
                  Card(
                    color: AppColors.smooky2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ' ${order.user?.fullname ?? '-'}الزبون ',
                            textAlign: TextAlign.right,
                            style: const TextStyle(color: AppColors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'هاتف: ${order.user?.phonenumber ?? '-'}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(color: AppColors.white),
                          ),
                          if (order.address != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              '${order.address}العنوان ',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                          if (order.tableNumber != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              'طاولة: ${order.tableNumber}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // --- Items ---
                  Text(
                    ': عناصر الطلب',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildItemsTable(context),
                  const SizedBox(height: 12),

                  // --- Coupon Info ---
                  if (order.coupon != null)
                    Card(
                      color: AppColors.smooky2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'كوبون: ${order.coupon?.code ?? '-'}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'قيمة الكوبون: ${order.coupon?.value ?? '-'}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'الحد الأدنى للطلب: ${order.coupon?.minOrder ?? '-'}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),

                  // --- Note & Total ---
                  if (order.note != null) ...[
                    Text(
                      'الملاحظة: ${order.note}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    'الإجمالي: ${_formatPrice(order.totalPrice)}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/archived_orders');
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.white),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'اغلاق',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemsTable(BuildContext context) {
    final items = order.items ?? [];
    final rc = ResponsiveConfig.of(context);

    if (rc.isMobile) {
      return Column(
        children:
        items.map((it) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.smooky2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  it.mealName ?? '-',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'النوع: ${it.typeName ?? '-'}',
                  style: const TextStyle(color: AppColors.white),
                ),
                Text(
                  'الكمية: ${it.amount ?? 0}  •  السعر: ${it.price ?? 0} ل.س',
                  style: const TextStyle(color: AppColors.white),
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return DataTable(
        columns: const [
          DataColumn(
            label: Text('الوجبة', style: TextStyle(color: AppColors.white)),
          ),
          DataColumn(
            label: Text('النوع', style: TextStyle(color: AppColors.white)),
          ),
          DataColumn(
            label: Text('الكمية', style: TextStyle(color: AppColors.white)),
          ),
          DataColumn(
            label: Text('السعر', style: TextStyle(color: AppColors.white)),
          ),
        ],
        rows:
        items.map((it) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  it.mealName ?? '-',
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
              DataCell(
                Text(
                  it.typeName ?? '-',
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
              DataCell(
                Text(
                  '${it.amount ?? 0}',
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
              DataCell(
                Text(
                  '${it.price ?? 0}',
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ],
          );
        }).toList(),
      );
    }
  }
}
