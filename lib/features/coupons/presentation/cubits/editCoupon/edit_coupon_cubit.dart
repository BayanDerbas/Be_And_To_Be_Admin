import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/edit_coupon_usecase.dart';

part 'edit_coupon_state.dart';

class EditCouponCubit extends Cubit<EditCouponState> {
  final EditCouponUseCase editCouponUseCase;

  EditCouponCubit(this.editCouponUseCase) : super(EditCouponInitial());

  Future<void> editPercentValue({
    required int value,
    required int coupon_id,
  }) async {
    emit(EditCouponLoading());
    final result = await editCouponUseCase.editPercentValue(
        value: value, coupon_id: coupon_id);

    result.fold(
          (failure) {
        emit(EditPercentValueFailure(failure.message));
      },
          (success) {
        emit(EditPercentValueSuccess(success.message));
      },
    );
  }

  Future<void> editMinOrder({
    required int min_order,
    required int coupon_id,
  }) async {
    emit(EditCouponLoading());
    final result = await editCouponUseCase.editMinOrder(
        min_order: min_order, coupon_id: coupon_id);

    result.fold(
          (failure) {
            print("Error in Cubit Coupon Edit : ${failure.message}");
        emit(EditMinOrderFailure(failure.message));
      },
          (success) {
        emit(EditMinOrderSuccess(success.message));
      },
    );
  }

  Future<void> editExpiresDate ({
    required String expires_at,
    required int coupon_id,
  }) async {
    emit(EditCouponLoading());
    final result = await editCouponUseCase.editExpiresDate(
        expires_at: expires_at, coupon_id: coupon_id);

    result.fold(
          (failure) {
        emit(EditExpiresDateFailure(failure.message));
      },
          (success) {
        emit(EditExpiresDateSuccess(success.message));
      },
    );
  }
}