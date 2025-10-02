part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}
class OrdersLoading extends OrdersState {}
class OrdersLoaded extends OrdersState {
  final Map<String, List<OrderEntity>> orders;
  OrdersLoaded(this.orders);
  @override
  List<Object?> get props => [orders];
}
class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
  @override
  List<Object?> get props => [message];
}

class AcceptOrder extends OrdersState {
  final String message;
  AcceptOrder(this.message);
  @override
  List<Object?> get props => [message];
}
