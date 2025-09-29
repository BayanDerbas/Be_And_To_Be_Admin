import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/networks/api_constant.dart';
import '../models/get_coupons/coupons_response_model.dart';

part 'coupons_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class CouponsService {
  factory CouponsService(Dio dio,{String baseUrl}) = _CouponsService;

  @GET(ApiConstant.show_coupons)
  Future<HttpResponse<CouponsResponseModel>> getCoupons();

  @POST(ApiConstant.add_coupon)
  Future<HttpResponse<dynamic>> addCoupon({
    @Query('code') required String code,
    @Query('min_order') required int min_order,
    @Query('percent_value') required int percent_value,
    @Query('expires_date') required String expires_date,
  });

  @POST(ApiConstant.edit_expires_date)
  Future<HttpResponse<dynamic>> editExpiresDate({
    @Query('expires_at') required String expires_at,
    @Query('coupon_id') required int coupon_id,
});

  @POST(ApiConstant.edit_minOrder)
  Future<HttpResponse<dynamic>> editMinOrder({
    @Query('min_order') required int min_order,
    @Query('coupon_id') required int coupon_id,
  });

  @POST(ApiConstant.edit_percentValue)
  Future<HttpResponse<dynamic>> editPercentValue({
    @Query('value')required int value,
    @Query('coupon_id') required int coupon_id,
  });

  @POST('${ApiConstant.delete_coupon}/{coupon_id}')
  Future<HttpResponse<dynamic>> deleteCoupon(@Path("coupon_id") int couponId);

}