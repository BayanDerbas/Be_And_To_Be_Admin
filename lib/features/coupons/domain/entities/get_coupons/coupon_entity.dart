import 'package:equatable/equatable.dart';

class CouponEntity extends Equatable {
  final int id;
  final String? code;
  final String? value;
  final String? minOrder;
  final String? expiresAt;
  final int? isActive;
  final int? branchId;
  final String? createdAt;
  final String? updatedAt;
  final CouponBranchEntity? branch;

  CouponEntity({
    required this.id,
     this.code,
     this.value,
     this.minOrder,
     this.expiresAt,
     this.isActive,
     this.branchId,
     this.createdAt,
     this.updatedAt,
     this.branch,
  });

  @override
  List<Object?> get props => [
    id,
    code,
    value,
    minOrder,
    expiresAt,
    isActive,
    branchId,
    createdAt,
    updatedAt,
    branch,
  ];
}

class CouponBranchEntity extends Equatable {
  final int id;
  final String? branchName;
  final String? image;
  final double? length;
  final double? width;

  const CouponBranchEntity({
    required this.id,
     this.branchName,
     this.image,
     this.length,
     this.width,
  });

  @override
  List<Object?> get props => [id, branchName, image, length, width];
}
