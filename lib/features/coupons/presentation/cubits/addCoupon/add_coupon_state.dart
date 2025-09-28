part of 'add_coupon_cubit.dart';

abstract class AddCouponState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCouponInitial extends AddCouponState {}

class AddCouponLoading extends AddCouponState {}

class AddCouponSuccess extends AddCouponState {
  final String message;

  AddCouponSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddCouponFailure extends AddCouponState {
  final String message;

  AddCouponFailure(this.message);

  @override
  List<Object> get props => [message];
}
