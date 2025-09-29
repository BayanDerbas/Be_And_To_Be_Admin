import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_percent_value_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_percent_value_model.g.dart';

@JsonSerializable()
class EditPercentValueModel extends EditPercentValueEntity {
  EditPercentValueModel({required super.message});
  factory EditPercentValueModel.fromJson(Map<String,dynamic> json) => _$EditPercentValueModelFromJson(json);
  Map<String,dynamic> toJson() => _$EditPercentValueModelToJson(this);
}