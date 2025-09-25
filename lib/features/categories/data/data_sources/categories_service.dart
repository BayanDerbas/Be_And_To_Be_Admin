import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../core/networks/api_constant.dart';
import '../models/category_model.dart';

part 'categories_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class CategoriesService {
  factory CategoriesService(Dio dio, {String baseUrl}) = _CategoriesService;

  @GET("/show_main_categories_admin/{branch_id}")
  Future<CategoriesResponseModel> getCategories(
      @Path("branch_id") int branch_id);
}
