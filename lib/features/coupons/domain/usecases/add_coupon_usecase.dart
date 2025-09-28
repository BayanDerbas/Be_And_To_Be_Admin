import 'package:be_and_to_be_admin/core/networks/failures.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/add_coupon/add_coupon_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/coupons_repository.dart';

class AddCouponUseCase {
  final CouponsRepository repository;
  AddCouponUseCase(this.repository);

  Future<Either<Failure, AddCouponResponseEntity>> call({
    required String code,
    required int min_order,
    required int percent_value,
    required String expires_date,
  }) async {
    return repository.addCoupon(
      code: code,
      min_order: min_order,
      percent_value: percent_value,
      expires_date: expires_date,
    );
  }
}
