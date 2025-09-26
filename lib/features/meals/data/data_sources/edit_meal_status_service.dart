import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/networks/api_constant.dart';
import '../models/meal_status_response.dart';

part 'edit_meal_status_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class EditMealStatusService {
  factory EditMealStatusService(Dio dio, {String baseUrl}) = _EditMealStatusService;

  @POST("${ApiConstant.make_meal_unavailable}/{mealType_id}")
  Future<HttpResponse<dynamic>> makeMealUnavailable(
      @Path('mealType_id') int mealType_id,
      );
}