import 'package:be_and_to_be_admin/features/orders/data/models/accept_order/accept_order_model.dart';
import 'package:be_and_to_be_admin/features/orders/domain/entities/accept_order/accept_order_entity.dart';
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

  @override
  Future<Either<Failure, AcceptOrderEntity>> accept_order({required int order_id, required String type}) async {
    try {
      final response = await service.accept_order(order_id: order_id, type: type);
      final data = response.data;
      late AcceptOrderEntity entity;
      if(data is Map<String,dynamic>){
        entity = AcceptOrderModel.fromJson(data);
      } else if (data is List && data.isNotEmpty){
        entity = AcceptOrderEntity(message: data.toString());
      } else {
        entity = AcceptOrderEntity(message: "Unexpected response format");
      }
      return Right(entity);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(Failure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<OrderEntity>>>> show_last_accepted_orders() async {
    try {
      final response = await service.get_accepted_orders();
      final OrdersResponseEntity data = response.data!.toEntity();
      final delivery = data.deliveryOrders ?? [];
      final table = data.tableOrders ?? [];
      final self = data.selfOrders ?? [];

      print("//////Accepted Orders Loaded///////");
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
