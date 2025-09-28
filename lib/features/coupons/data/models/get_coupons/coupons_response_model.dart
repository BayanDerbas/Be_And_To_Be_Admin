import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/get_coupons/coupons_entity.dart';
import 'coupon_model.dart';

part 'coupons_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CouponsResponseModel extends CouponsEntity {
  @override
  @JsonKey(name: 'All coupons')
  final List<CouponModel> coupons;

  CouponsResponseModel(this.coupons) : super(coupons);

  factory CouponsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CouponsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponsResponseModelToJson(this);
}
