import 'package:be_and_to_be_admin/core/networks/failures.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/delete_coupon/delete_coupon_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/repositories/coupons_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCouponUseCase {
  final CouponsRepository repository;

  DeleteCouponUseCase(this.repository);
  Future<Either<Failure,DeleteCouponEntity>> call({required int coupon_id}) async {
    return repository.deleteCoupon(coupon_id: coupon_id);
  }
}