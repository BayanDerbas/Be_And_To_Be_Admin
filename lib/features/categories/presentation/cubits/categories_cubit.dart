import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_categories_usecase.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesCubit(this.getCategoriesUseCase) : super(CategoriesInitial());

  Future<void> fetchCategories(int branchId) async {
    emit(CategoriesLoading());
    final result = await getCategoriesUseCase(branchId);
    result.fold(
          (failure) => emit(CategoriesFailure(failure.message)),
          (categories) => emit(CategoriesSuccess(categories)),
    );
  }
}
