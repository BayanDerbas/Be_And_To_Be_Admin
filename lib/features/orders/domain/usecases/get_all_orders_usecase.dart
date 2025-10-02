import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/get_all_orders/orders_entity.dart';
import '../repositories/orders_repository.dart';

class GetAllOrdersUseCase {
  final OrdersRepository repository;
  GetAllOrdersUseCase(this.repository);

  Future<Either<Failure, Map<String, List<OrderEntity>>>> call() {
    return repository.getAllOrders();
  }
}