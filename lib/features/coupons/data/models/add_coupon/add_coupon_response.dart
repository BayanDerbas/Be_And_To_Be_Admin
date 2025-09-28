import 'package:be_and_to_be_admin/features/coupons/domain/entities/add_coupon/add_coupon_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_coupon_response.g.dart';

@JsonSerializable()
class AddCouponResponse extends AddCouponResponseEntity {
  AddCouponResponse({required super.message});

  factory AddCouponResponse.fromJson(Map<String,dynamic> json) => _$AddCouponResponseFromJson(json);
  Map<String,dynamic> toJson() => _$AddCouponResponseToJson(this);
}