import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/get_all_orders/orders_entity.dart';
import '../../../domain/usecases/get_all_orders_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetAllOrdersUseCase useCase;
  OrdersCubit(this.useCase) : super(OrdersInitial());

  Future<void> fetchAllOrders() async {
    emit(OrdersLoading());
    final result = await useCase();
    result.fold(
          (failure) => emit(OrdersError(failure.message)),
          (orders) => emit(OrdersLoaded(orders)),
    );
  }
}