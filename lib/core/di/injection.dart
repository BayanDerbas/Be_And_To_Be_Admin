import 'package:be_and_to_be_admin/features/meals/data/data_sources/edit_meal_status_service.dart';
import 'package:be_and_to_be_admin/features/meals/data/repositories/meal_status_repository_impl.dart';
import 'package:be_and_to_be_admin/features/meals/data/repositories/meal_types_repository_impl.dart';
import 'package:be_and_to_be_admin/features/meals/domain/repositories/get_types_of_meal_repository.dart';
import 'package:be_and_to_be_admin/features/meals/domain/repositories/meal_status_repository.dart';
import 'package:be_and_to_be_admin/features/meals/domain/usecases/get_meals_of_category_usecase.dart';
import 'package:be_and_to_be_admin/features/meals/domain/usecases/get_types_of_meal_usecase.dart';
import 'package:be_and_to_be_admin/features/meals/domain/usecases/make_meal_unavailable_usecase.dart';
import 'package:be_and_to_be_admin/features/meals/presentation/cubits/meal_types_cubit/meal_types_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/data_sources/login/login_service.dart';
import '../../features/auth/data/data_sources/logout/logout_service.dart';
import '../../features/auth/data/data_sources/refresh/refresh_service.dart';
import '../../features/auth/data/repositories/login/login_repository_impl.dart';
import '../../features/auth/data/repositories/logout/logout_repository_impl.dart';
import '../../features/auth/data/repositories/refresh/refresh_respository_impl.dart';
import '../../features/auth/domain/repositories/login/login_repository.dart';
import '../../features/auth/domain/repositories/logout/logout_repository.dart';
import '../../features/auth/domain/repositories/refresh/refresh_repository.dart';
import '../../features/auth/domain/usecases/login/login_usecase.dart';
import '../../features/auth/domain/usecases/logout/logout_usecase.dart';
import '../../features/auth/domain/usecases/refresh/refresh_usecase.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/logout/logout_cubit.dart';
import '../../features/auth/presentation/cubit/refresh/refresh_cubit.dart';
import '../../features/branches/data/data_sources/branches_service.dart';
import '../../features/branches/data/repositories/branches_repository_impl.dart';
import '../../features/branches/domain/repositories/branches_repository.dart';
import '../../features/branches/domain/usecases/branches_usecase.dart';
import '../../features/branches/presentation/cubits/get_branches/branch_cubit.dart';
import '../../features/categories/data/data_sources/categories_service.dart';
import '../../features/categories/data/repositories/categories_repository_impl.dart';
import '../../features/categories/domain/repositories/categories_repository.dart';
import '../../features/categories/domain/usecases/get_categories_usecase.dart';
import '../../features/categories/presentation/cubits/categories_cubit.dart';
import '../../features/meals/data/data_sources/meal_service.dart';
import '../../features/meals/data/data_sources/meal_types_service.dart';
import '../../features/meals/data/repositories/meal_repository_impl.dart';
import '../../features/meals/domain/repositories/meal_repository.dart';
import '../../features/meals/presentation/cubits/meals/meals_cubit.dart';
import '../networks/dio_factory.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dio
  final dio = await DioFactory.getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  // Data sources
  sl.registerLazySingleton<LoginService>(() => LoginService(sl<Dio>()));
  sl.registerLazySingleton<LogoutService>(() => LogoutService(sl<Dio>()));
  sl.registerLazySingleton<RefreshService>(() => RefreshService(sl<Dio>()));
  sl.registerLazySingleton<BranchesService>(() => BranchesService(sl<Dio>()));
  sl.registerLazySingleton<CategoriesService>(() => CategoriesService(sl<Dio>()));
  sl.registerLazySingleton<MealService>(() => MealService(sl<Dio>()));
  sl.registerLazySingleton<MealTypesService>(() => MealTypesService(sl<Dio>()));
  sl.registerLazySingleton<EditMealStatusService>(() => EditMealStatusService(sl<Dio>()));

  // Repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl<LoginService>()));
  sl.registerLazySingleton<LogoutRepository>(() => LogoutRepositoryImpl(sl<LogoutService>()));
  sl.registerLazySingleton<RefreshRepository>(() => RefreshRepositoryImpl(sl<RefreshService>()));
  sl.registerLazySingleton<BranchesRepository>(() => BranchesRepositoryImpl(sl<BranchesService>()));
  sl.registerLazySingleton<CategoriesRepository>(() => CategoriesRepositoryImpl(sl<CategoriesService>()));
  sl.registerLazySingleton<MealRepository>(() => MealRepositoryImpl(sl<MealService>()));
  sl.registerLazySingleton<MealTypesRepository>(() => MealTypesRepositoryImpl(sl<MealTypesService>()));
  sl.registerLazySingleton<MealStatusRepository>(() => MealStatusRepositoryImpl(sl<EditMealStatusService>()));


  // UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<LoginRepository>()));
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl<LogoutRepository>()));
  sl.registerLazySingleton<RefreshUseCase>(() => RefreshUseCase(sl<RefreshRepository>()));
  sl.registerLazySingleton<BranchesUseCase>(() => BranchesUseCase(sl<BranchesRepository>()));
  sl.registerLazySingleton<GetCategoriesUseCase>(() => GetCategoriesUseCase(sl<CategoriesRepository>()));
  sl.registerLazySingleton<GetMealOfCategoryUseCase>(() => GetMealOfCategoryUseCase(sl<MealRepository>()));
  sl.registerLazySingleton<GetTypesOfMealUseCase>(() => GetTypesOfMealUseCase(sl<MealTypesRepository>()));
  sl.registerLazySingleton<MakeMealStatusUseCase>(() => MakeMealStatusUseCase(sl<MealStatusRepository>()));


  // Cubits
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(sl<LoginUseCase>()));
  sl.registerLazySingleton<LogoutCubit>(() => LogoutCubit(sl<LogoutUseCase>()));
  sl.registerLazySingleton<RefreshCubit>(() => RefreshCubit(sl<RefreshUseCase>()));
  sl.registerFactory<BranchCubit>(() => BranchCubit(sl<BranchesUseCase>()));
  sl.registerFactory(() => CategoriesCubit(sl<GetCategoriesUseCase>()));
  sl.registerFactory(() => MealsCubit(sl<GetMealOfCategoryUseCase>()));
  sl.registerLazySingleton<MealTypesCubit>(() => MealTypesCubit(sl<GetTypesOfMealUseCase>(),sl<MakeMealStatusUseCase>()));
}
