import 'package:be_and_to_be_admin/features/coupons/domain/entities/get_coupons/coupons_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/usecases/get_coupons_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_coupons_state.dart';

class GetCouponsCubit extends Cubit<GetCouponsState> {
  final GetCouponsUseCase useCase;
  GetCouponsCubit(this.useCase) : super(GetCouponsInitial());

  Future<void> getCoupons() async {
    emit(GetCouponsLoading());
    final result = await useCase.call();
    result.fold(
            (failure){
              emit(GetCouponsFailure(failure.message));
              print("Failure from Coupons Cubit : ${failure.message}");
            },
            (coupons){
              emit(GetCouponsSuccess(coupons));
              print("Success from Coupons Cubit : ${coupons}");
            },
    );
  }
}
