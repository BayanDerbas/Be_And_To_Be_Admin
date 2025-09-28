// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => CouponModel(
  id: (json['id'] as num).toInt(),
  code: json['code'] as String?,
  value: json['value'] as String?,
  minOrder: json['min_order'] as String?,
  expiresAt: json['expires_at'] as String?,
  isActive: (json['is_active'] as num?)?.toInt(),
  branchId: (json['branch_id'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  branch:
      json['branch'] == null
          ? null
          : CouponBranchModel.fromJson(json['branch'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'value': instance.value,
      'min_order': instance.minOrder,
      'expires_at': instance.expiresAt,
      'is_active': instance.isActive,
      'branch_id': instance.branchId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'branch': instance.branch,
    };

CouponBranchModel _$CouponBranchModelFromJson(Map<String, dynamic> json) =>
    CouponBranchModel(
      id: (json['id'] as num).toInt(),
      branchName: json['branch_name'] as String?,
      image: json['image'] as String?,
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CouponBranchModelToJson(CouponBranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_name': instance.branchName,
      'image': instance.image,
      'length': instance.length,
      'width': instance.width,
    };
