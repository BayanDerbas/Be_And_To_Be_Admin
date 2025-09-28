import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/get_coupons/coupons_entity.dart';
import '../repositories/coupons_repository.dart';

class GetCouponsUseCase {
  final CouponsRepository repository;

  GetCouponsUseCase(this.repository);

  Future<Either<Failure, CouponsEntity>> call() async {
    return await repository.getAllCoupons();
  }
}
