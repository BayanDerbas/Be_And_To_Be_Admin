import 'package:be_and_to_be_admin/core/networks/failures.dart';
import 'package:be_and_to_be_admin/features/meals/domain/entities/meal_status_entity.dart';
import 'package:be_and_to_be_admin/features/meals/domain/repositories/meal_status_repository.dart';
import 'package:dartz/dartz.dart';

class MakeMealStatusUseCase {
  final MealStatusRepository repository;
  MakeMealStatusUseCase(this.repository);

  Future<Either<Failure,MealStatusEntity>> call(int mealType_id) async{
    return repository.makeMealUnavailable(mealType_id);
  }
}