import 'package:equatable/equatable.dart';

class DeleteCouponEntity extends Equatable {
  final String message;

  DeleteCouponEntity({required this.message});
  @override
  List<Object?> get props => [message];

}