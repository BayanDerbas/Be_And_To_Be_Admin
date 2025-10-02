import 'package:be_and_to_be_admin/features/orders/domain/entities/accept_order/accept_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accept_order_model.g.dart';

@JsonSerializable()
class AcceptOrderModel extends AcceptOrderEntity {
  AcceptOrderModel({required super.message});

  factory AcceptOrderModel.fromJson(Map<String,dynamic> json) => _$AcceptOrderModelFromJson(json);
  Map<String,dynamic> toJson() => _$AcceptOrderModelToJson(this);
}