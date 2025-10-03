import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/get_all_orders/orders_entity.dart';
import '../../../domain/usecases/orders_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersUseCase useCase;
  OrdersCubit(this.useCase) : super(OrdersInitial());

  Future<void> fetchAllOrders() async {
    emit(OrdersLoading());
    final result = await useCase.getAllOrders();
    result.fold(
          (failure) => emit(OrdersError(failure.message)),
          (orders) => emit(OrdersLoaded(orders)),
    );
  }
  Future<void> fetchAcceptOrders({
    required int order_id,
    required String type,
}) async {
    emit(OrdersLoading());
    final result = await useCase.accept_orders(order_id: order_id, type: type);
    result.fold(
            (failure){
              emit(OrdersError(failure.message));
            },
            (accept){
              emit(AcceptOrder(accept.message));
            },
    );
  }
  Future<void> fetchAcceptedAllOrders() async {
    emit(OrdersLoading());
    final result = await useCase.show_last_accepted_orders();
    result.fold(
          (failure) => emit(OrdersError(failure.message)),
          (orders) => emit(OrdersLoaded(orders)),
    );
  }
  Future<void> fetchArchivesAllOrders() async {
    emit(OrdersLoading());
    final result = await useCase.show_archive_orders();
    result.fold(
          (failure) => emit(OrdersError(failure.message)),
          (orders) => emit(OrdersLoaded(orders)),    );
  }
}