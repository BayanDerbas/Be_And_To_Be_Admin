import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_min_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_min_order_model.g.dart';

@JsonSerializable()
class EditMinOrderModel extends EditMinOrderEntity{
  EditMinOrderModel({required super.message});
  factory EditMinOrderModel.fromJson(Map<String,dynamic> json) => _$EditMinOrderModelFromJson(json);
  Map<String,dynamic> toJson() => _$EditMinOrderModelToJson(this);
}