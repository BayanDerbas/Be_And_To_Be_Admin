import 'package:be_and_to_be_admin/features/coupons/domain/entities/add_coupon/add_coupon_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/get_coupons/coupons_entity.dart';

abstract class CouponsRepository {
  Future<Either<Failure, CouponsEntity>> getAllCoupons();
  Future<Either<Failure,AddCouponResponseEntity>> addCoupon({
    required String code,
    required int min_order,
    required int percent_value,
    required String expires_date,
});
}
