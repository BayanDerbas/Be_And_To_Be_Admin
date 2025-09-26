import 'package:be_and_to_be_admin/core/networks/failures.dart';
import 'package:be_and_to_be_admin/features/meals/domain/entities/meal_status_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MealStatusRepository{
  Future<Either<Failure,MealStatusEntity>> makeMealUnavailable(int mealType_id);
}