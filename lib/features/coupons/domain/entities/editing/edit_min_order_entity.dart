import 'package:equatable/equatable.dart';

class EditMinOrderEntity extends Equatable {
  final String message;
  EditMinOrderEntity({required this.message});
  @override
  List<Object?> get props => [message];
}