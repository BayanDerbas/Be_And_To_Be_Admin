import 'package:be_and_to_be_admin/features/coupons/domain/usecases/delete_coupon_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_coupon_state.dart';

class DeleteCouponCubit extends Cubit<DeleteCouponState> {
  final DeleteCouponUseCase useCase;
  DeleteCouponCubit(this.useCase) : super(DeleteCouponInitial());

  Future<void> deleteCoupon({required int coupon_id}) async {
    emit(DeleteCouponLoading());
    try {
      final result = await useCase.call(coupon_id: coupon_id);
      result.fold(
            (failure) => emit(DeleteCouponFailure(failure.message)),
            (success) => emit(DeleteCouponSuccess(success.message)),
      );
    } catch (e) {
      emit(DeleteCouponFailure('حدث خطأ غير متوقع'));
      print('DeleteCouponCubit exception: $e');
    }
  }

}
