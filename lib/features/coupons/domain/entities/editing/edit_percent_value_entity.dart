import 'package:equatable/equatable.dart';

class EditPercentValueEntity extends Equatable {
  final String message;

  EditPercentValueEntity({required this.message});
  @override
  List<Object?> get props => [message];

}