import 'package:be_and_to_be_admin/features/coupons/domain/entities/delete_coupon/delete_coupon_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_coupon_model.g.dart';

@JsonSerializable()
class DeleteCouponModel extends DeleteCouponEntity {
  DeleteCouponModel({required super.message});
  factory DeleteCouponModel.fromJson(Map<String,dynamic> json) => _$DeleteCouponModelFromJson(json);
  Map<String,dynamic> toJson() => _$DeleteCouponModelToJson(this);
}