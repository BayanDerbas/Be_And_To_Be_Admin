import 'package:equatable/equatable.dart';
import 'coupon_entity.dart';

class CouponsEntity extends Equatable {
  final List<CouponEntity> coupons;

  CouponsEntity(this.coupons);
  @override
  List<Object?> get props => [coupons];
}