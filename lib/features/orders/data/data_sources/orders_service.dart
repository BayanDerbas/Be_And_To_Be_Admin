import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../core/networks/api_constant.dart';
import '../models/get_all_orders/order_repsponse_model.dart';

part 'orders_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class OrdersService {
  factory OrdersService(Dio dio, {String baseUrl}) = _OrdersService;

  @GET(ApiConstant.show_all_orders)
  Future<HttpResponse<OrdersResponseModel>> getAllOrders();

  @POST(ApiConstant.accept_order)
  Future<HttpResponse<dynamic>> accept_order({
    @Query('order_id') required int order_id,
    @Query('type') required String type,
});
}

