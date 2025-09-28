import 'package:be_and_to_be_admin/features/coupons/domain/usecases/add_coupon_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_coupon_state.dart';

class AddCouponCubit extends Cubit<AddCouponState> {
  final AddCouponUseCase useCase;
  AddCouponCubit(this.useCase) : super(AddCouponInitial());

  Future<void> addCoupon({
    required String code,
    required int min_order,
    required int percent_value,
    required String expires_date,
  }) async {
    emit(AddCouponLoading());
    final result = await useCase.call(
      code: code,
      min_order: min_order,
      percent_value: percent_value,
      expires_date: expires_date,
    );
    result.fold(
          (failure) {
        print("❌ AddCouponCubit Error: ${failure.message}");
        emit(AddCouponFailure(failure.message));
      },
          (couponEntity) {
        print("✅ AddCouponCubit Success: ${couponEntity.message}");
        emit(AddCouponSuccess(couponEntity.message));
      },
    );
  }
}
