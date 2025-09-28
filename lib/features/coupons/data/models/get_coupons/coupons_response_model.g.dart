// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupons_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponsResponseModel _$CouponsResponseModelFromJson(
  Map<String, dynamic> json,
) => CouponsResponseModel(
  (json['All coupons'] as List<dynamic>)
      .map((e) => CouponModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CouponsResponseModelToJson(
  CouponsResponseModel instance,
) => <String, dynamic>{
  'All coupons': instance.coupons.map((e) => e.toJson()).toList(),
};
