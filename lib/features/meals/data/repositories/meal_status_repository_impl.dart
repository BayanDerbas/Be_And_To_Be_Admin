import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/networks/failures.dart';
import '../../domain/entities/meal_status_entity.dart';
import '../../domain/repositories/meal_status_repository.dart';
import '../data_sources/edit_meal_status_service.dart';
import '../models/meal_status_response.dart';

class MealStatusRepositoryImpl implements MealStatusRepository {
  final EditMealStatusService service;

  MealStatusRepositoryImpl(this.service);

  @override
  Future<Either<Failure, MealStatusEntity>> makeMealUnavailable(int mealType_id) async {
    try {
      final response = await service.makeMealUnavailable(mealType_id);
      final data = response.data;

      late MealStatusEntity entity;

      if (data is Map<String, dynamic>) {
        entity = MealStatusResponse.fromJson(data);
      } else if (data is List && data.isNotEmpty) {
        entity = MealStatusEntity(message: data.toString());
      } else {
        entity = MealStatusEntity(message: "Unexpected response format");
      }

      return Right(entity);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(Failure('An unexpected error occurred: $e'));
    }
  }
}
