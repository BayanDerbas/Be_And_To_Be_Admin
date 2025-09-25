import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories(int branch_id);
}
