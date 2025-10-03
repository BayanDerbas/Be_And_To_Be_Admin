import 'package:be_and_to_be_admin/features/orders/domain/entities/accept_order/accept_order_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/get_all_orders/orders_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, Map<String, List<OrderEntity>>>> getAllOrders();
  Future<Either<Failure,AcceptOrderEntity>> accept_order({
    required int order_id,
    required String type,
});
  Future<Either<Failure, Map<String, List<OrderEntity>>>> show_last_accepted_orders();
}