import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../../../../core/networks/failures.dart';
import '../data_sources/categories_service.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesService service;

  CategoriesRepositoryImpl(this.service);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories(int branch_id) async {
    try {
      final result = await service.getCategories(branch_id);
      return Right(result.categories);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
