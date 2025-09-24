import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/register/register_user.dart';

part 'register_user_model.g.dart';

@JsonSerializable()
class RegisterUserModel extends RegisterUserEntity {
  RegisterUserModel({
    required String fullname,
    required String phonenumber,
    required String role,
    required DateTime created_at,
    required DateTime updated_at,
    required int id,
  }) : super (
    fullname: fullname,
    phonenumber: phonenumber,
    role: role,
    created_at: created_at,
    updated_at: updated_at,
    id: id,
  );

  factory RegisterUserModel.fromJson(Map<String,dynamic> json) => _$RegisterUserModelFromJson(json);
  Map<String,dynamic> toJson() => _$RegisterUserModelToJson(this);
}
