import 'package:be_and_to_be_admin/features/meals/domain/usecases/make_meal_unavailable_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/entities/meal_with_types_entity.dart';
import '../../../domain/usecases/get_types_of_meal_usecase.dart';

part 'meal_types_state.dart';

class MealTypesCubit extends Cubit<MealTypesState> {
  final GetTypesOfMealUseCase useCase;
  final MakeMealStatusUseCase useCase_;
  MealTypesCubit(this.useCase, this.useCase_) : super(MealTypesInitial());
  int? _currentMealId;

  Future<void> getMealsTypes(int mealId) async {
    _currentMealId = mealId;
    emit(MealTypesLoading());
    final result = await useCase(mealId);
    result.fold(
      (failure) {
        debugPrint("❌ MealTypesCubit Error: ${failure.message}");
        emit(MealTypesFailure(message: failure.message));
      },
      (meals) {
        debugPrint("✅ MealTypesCubit Success: meals loaded for mealId $mealId");
        emit(MealTypesSuccess(meals));
      },
    );
  }

  Future<void> makeUnavailable(int mealType_id) async {
    final result = await useCase_(mealType_id);
    result.fold(
      (failure) {
        print("Make Meal Unavailbale Cubit Error : ${failure.message}");
        emit(MakeMealUnavailableFailure(failure.message));
      },
      (response) async{
        print("Make Meal Unavailbale Cubit Success : ${response.message}");
        emit(MakeMealUnavailableSuccess(response.message));
        if (_currentMealId != null) {
          await getMealsTypes(_currentMealId!);
        }
      },
    );
  }
}
