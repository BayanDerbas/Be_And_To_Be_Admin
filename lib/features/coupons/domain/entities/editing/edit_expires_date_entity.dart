import 'package:equatable/equatable.dart';

class EditExpiresDateEntity extends Equatable {
  final String message;
  EditExpiresDateEntity({required this.message});
  @override
  List<Object?> get props => [message];
}