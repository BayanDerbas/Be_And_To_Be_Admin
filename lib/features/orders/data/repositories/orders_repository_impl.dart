import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/entities/get_all_orders/orders_entity.dart';
import '../../domain/repositories/orders_repository.dart';
import '../data_sources/orders_service.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersService service;
  OrdersRepositoryImpl(this.service);

  @override
  Future<Either<Failure, Map<String, List<OrderEntity>>>> getAllOrders() async {
    try {
      final response = await service.getAllOrders();
      final OrdersResponseEntity data = response.data!.toEntity();
      final delivery = data.deliveryOrders ?? [];
      final table = data.tableOrders ?? [];
      final self = data.selfOrders ?? [];

      print("//////Orders Loaded///////");
      print("Delivery: ${delivery.length}, Table: ${table.length}, Self: ${self.length}");

      return Right({
        'delivery': delivery,
        'table': table,
        'self': self,
      });

    } on DioException catch (e) {
      print(Failure.fromDioError(e));
      return Left(Failure.fromDioError(e));
    } catch (e) {
      print(Failure(e.toString()));
      return Left(Failure('Unknown error: $e'));
    }
  }
}
