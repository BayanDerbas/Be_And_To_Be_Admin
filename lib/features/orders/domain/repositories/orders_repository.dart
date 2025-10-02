import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/get_all_orders/orders_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, Map<String, List<OrderEntity>>>> getAllOrders();
}