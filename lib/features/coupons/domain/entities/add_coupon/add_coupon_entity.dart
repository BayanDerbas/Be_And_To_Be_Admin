import 'package:equatable/equatable.dart';

class AddCouponResponseEntity extends Equatable {
  final String message;
  AddCouponResponseEntity({required this.message});

  @override
  List<Object?> get props => [message];
}