import 'package:be_and_to_be_admin/features/orders/domain/entities/accept_order/accept_order_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/get_all_orders/orders_entity.dart';
import '../repositories/orders_repository.dart';

class OrdersUseCase {
  final OrdersRepository repository;
  OrdersUseCase(this.repository);

  Future<Either<Failure, Map<String, List<OrderEntity>>>> getAllOrders() {
    return repository.getAllOrders();
  }
  Future<Either<Failure,AcceptOrderEntity>> accept_orders({
    required int order_id,
    required String type,
}) async {
    return repository.accept_order(order_id: order_id, type: type);
}
  Future<Either<Failure,Map<String,List<OrderEntity>>>> show_last_accepted_orders(){
    return repository.show_last_accepted_orders();
  }
}