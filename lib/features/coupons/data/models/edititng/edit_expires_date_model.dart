import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_expires_date_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_expires_date_model.g.dart';

@JsonSerializable()
class EditExpiresDateModel extends EditExpiresDateEntity {
  EditExpiresDateModel({required super.message});

  factory EditExpiresDateModel.fromJson(Map<String,dynamic> json) => _$EditExpiresDateModelFromJson(json);
  Map<String,dynamic> toJson() => _$EditExpiresDateModelToJson(this);
}