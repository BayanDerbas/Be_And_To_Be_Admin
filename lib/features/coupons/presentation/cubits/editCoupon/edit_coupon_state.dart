part of 'edit_coupon_cubit.dart';

abstract class EditCouponState extends Equatable {
  const EditCouponState();
  @override
  List<Object?> get props => [];
}

final class EditCouponInitial extends EditCouponState {}
final class EditCouponLoading extends EditCouponState {}

final class EditPercentValueSuccess extends EditCouponState {
  final String message;
  const EditPercentValueSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

final class EditPercentValueFailure extends EditCouponState {
  final String message;
  const EditPercentValueFailure(this.message);
  @override
  List<Object?> get props => [message];
}

final class EditMinOrderSuccess extends EditCouponState {
  final String message;
  const EditMinOrderSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

final class EditMinOrderFailure extends EditCouponState {
  final String message;
  const EditMinOrderFailure(this.message);
  @override
  List<Object?> get props => [message];
}

final class EditExpiresDateSuccess extends EditCouponState {
  final String message;
  const EditExpiresDateSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

final class EditExpiresDateFailure extends EditCouponState {
  final String message;
  const EditExpiresDateFailure(this.message);
  @override
  List<Object?> get props => [message];
}