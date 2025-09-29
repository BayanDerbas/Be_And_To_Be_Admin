import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_expires_date_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_min_order_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_percent_value_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/repositories/coupons_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';

class EditCouponUseCase {
  final CouponsRepository repository;
  EditCouponUseCase(this.repository);

  Future<Either<Failure, EditPercentValueEntity>> editPercentValue(
      {required int value, required int coupon_id}) async {
    return repository.editPercentValue(value: value, coupon_id: coupon_id);
  }

  Future<Either<Failure, EditMinOrderEntity>> editMinOrder(
      {required int min_order, required int coupon_id}) async {
    return repository.editMinOrder(min_order: min_order, coupon_id: coupon_id);
  }

  Future<Either<Failure, EditExpiresDateEntity>> editExpiresDate(
      {required String expires_at, required int coupon_id}) async {
    return repository.editExpiresDate(expires_at: expires_at, coupon_id: coupon_id);
  }
}