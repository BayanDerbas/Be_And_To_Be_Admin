part of 'delete_coupon_cubit.dart';

abstract class DeleteCouponState extends Equatable{
  @override
  List<Object?> get props => [];
}

class DeleteCouponInitial extends DeleteCouponState {}

class DeleteCouponLoading extends DeleteCouponState {}

class DeleteCouponSuccess extends DeleteCouponState {
  final String message;

  DeleteCouponSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class DeleteCouponFailure extends DeleteCouponState {
  final String message;

  DeleteCouponFailure(this.message);
  @override
  List<Object?> get props => [message];
}

