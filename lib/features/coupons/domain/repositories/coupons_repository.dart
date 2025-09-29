import 'package:be_and_to_be_admin/features/coupons/domain/entities/add_coupon/add_coupon_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/delete_coupon/delete_coupon_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_expires_date_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_min_order_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_percent_value_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/get_coupons/coupons_entity.dart';

abstract class CouponsRepository {
  Future<Either<Failure, CouponsEntity>> getAllCoupons();
  Future<Either<Failure, AddCouponResponseEntity>> addCoupon({
    required String code,
    required int min_order,
    required int percent_value,
    required String expires_date,
  });
  Future<Either<Failure, EditMinOrderEntity>> editMinOrder({
    required int min_order,
    required int coupon_id,
  });
  Future<Either<Failure, EditPercentValueEntity>> editPercentValue({
    required int value,
    required int coupon_id,
  });
  Future<Either<Failure, EditExpiresDateEntity>> editExpiresDate({
    required String expires_at,
    required int coupon_id,
  });
  Future<Either<Failure, DeleteCouponEntity>> deleteCoupon({
    required int coupon_id,
  });
}
