import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/get_coupons/coupon_entity.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class CouponModel extends CouponEntity {
  @override
  final int id;
  @override
  final String? code;
  @override
  final String? value;
  @override
  @JsonKey(name: 'min_order')
  final String? minOrder;
  @override
  @JsonKey(name: 'expires_at')
  final String? expiresAt;
  @override
  @JsonKey(name: 'is_active')
  final int? isActive;
  @override
  @JsonKey(name: 'branch_id')
  final int? branchId;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'branch')
  final CouponBranchModel? branch;

  CouponModel({
    required this.id,
    required this.code,
    required this.value,
    required this.minOrder,
    required this.expiresAt,
    required this.isActive,
    required this.branchId,
    required this.createdAt,
    required this.updatedAt,
    this.branch,
  }) : super(
    id: id ,
    code: code,
    value: value,
    minOrder: minOrder,
    expiresAt: expiresAt,
    isActive: isActive,
    branchId: branchId,
    createdAt: createdAt,
    updatedAt: updatedAt,
    branch: branch,
  );

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}

@JsonSerializable()
class CouponBranchModel extends CouponBranchEntity {
  @override
  final int id;
  @override
  @JsonKey(name: 'branch_name')
  final String? branchName;
  @override
  final String? image;
  @override
  final double? length;
  @override
  final double? width;

  const CouponBranchModel({
    required this.id,
    required this.branchName,
    required this.image,
    required this.length,
    required this.width,
  }) : super(
    id: id,
    branchName: branchName,
    image: image,
    length: length,
    width: width,
  );

  factory CouponBranchModel.fromJson(Map<String, dynamic> json) =>
      _$CouponBranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponBranchModelToJson(this);
}