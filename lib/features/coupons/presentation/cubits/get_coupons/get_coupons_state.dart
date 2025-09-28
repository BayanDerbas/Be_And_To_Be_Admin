part of 'get_coupons_cubit.dart';

abstract class GetCouponsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetCouponsInitial extends GetCouponsState {}

class GetCouponsLoading extends GetCouponsState {}

class GetCouponsSuccess extends GetCouponsState {
  final CouponsEntity coupons;

  GetCouponsSuccess(this.coupons);
  @override
  List<Object?> get props => [coupons];
}

class GetCouponsFailure extends GetCouponsState {
  final String message;

  GetCouponsFailure(this.message);
  @override
  List<Object?> get props => [message];
}
