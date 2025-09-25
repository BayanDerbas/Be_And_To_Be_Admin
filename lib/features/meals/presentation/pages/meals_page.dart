import 'package:be_and_to_be_admin/core/networks/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart' as di;
import '../../../branches/domain/entities/branch_entity.dart';
import '../../../branches/presentation/cubits/get_branches/branch_cubit.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../categories/presentation/cubits/categories_cubit.dart';
import '../cubits/meal_types_cubit/meal_types_cubit.dart';
import '../cubits/meals/meals_cubit.dart';
import '../widgets/customMealsHeaderRow.dart';
import '../widgets/customMealsTile.dart';
import 'mealTypes_dialog.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  BranchEntity? selectedBranch;
  CategoryEntity? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<BranchCubit>()..fetchBranches(),
        ), // 🔹 أول شيء يجيب الفروع
        BlocProvider(create: (_) => di.sl<CategoriesCubit>()),
        BlocProvider(create: (_) => di.sl<MealsCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.smooky,
          title: const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'الوجبات',
              style: TextStyle(
                color: AppColors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            // 🔹 Dropdown الفروع
            BlocBuilder<BranchCubit, BranchState>(
              builder: (context, branchState) {
                if (branchState is BranchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (branchState is BranchSuccess) {
                  final branches = branchState.branches.branches;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.smooky2,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.grey1),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButton<BranchEntity>(
                          value: selectedBranch,
                          hint: const Text(
                            "اختر الفرع",
                            style: TextStyle(color: AppColors.amber),
                          ),
                          isExpanded: true,
                          dropdownColor: AppColors.smooky2,
                          underline: const SizedBox(),
                          style: const TextStyle(color: AppColors.white),
                          items:
                              branches.map((branch) {
                                return DropdownMenuItem(
                                  value: branch,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      branch.branch_name ?? "Unnamed",
                                      style: const TextStyle(
                                        color: AppColors.amber,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (branch) {
                            setState(() {
                              selectedBranch = branch;
                              selectedCategory = null; // reset التصنيف
                            });
                            if (branch != null) {
                              context.read<CategoriesCubit>().fetchCategories(
                                branch.id,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            if (selectedBranch != null)
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesSuccess) {
                    final categories = state.categories;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.smooky2,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.grey1),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButton<CategoryEntity>(
                            value: selectedCategory,
                            hint: const Text(
                              "اختر التصنيف",
                              style: TextStyle(color: AppColors.amber),
                            ),
                            isExpanded: true,
                            dropdownColor: AppColors.smooky2,
                            underline: const SizedBox(),
                            style: const TextStyle(color: AppColors.white),
                            items:
                                categories.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        category.name,
                                        style: const TextStyle(
                                          color: AppColors.amber,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (category) {
                              setState(() {
                                selectedCategory = category;
                              });
                              if (category != null) {
                                context.read<MealsCubit>().fetchMeals(
                                  category.id,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),

            const CustomMealsHeaderRow(),

            Expanded(
              child: BlocBuilder<MealsCubit, MealsState>(
                builder: (context, state) {
                  if (state is MealsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MealsSuccess) {
                    final meals = state.meals;
                    return ListView.builder(
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        final meal = meals[index];
                        return GestureDetector(
                          onTap: () {
                            final mealTypesCubit =
                                context.read<MealTypesCubit>();
                            mealTypesCubit.getMealsTypes(meal.id);

                            showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value: mealTypesCubit,
                                  child: MealTypesDialog(
                                    mealName: meal.name,
                                    mealImage: meal.image,
                                  ),
                                );
                              },
                            );
                          },
                          child: CustomMealsTile(
                            name: meal.name,
                            image: '${ApiConstant.imageBase}${meal.image}',
                            description: meal.description,
                          ),
                        );
                      },
                    );
                  } else if (state is MealsFailure) {
                    return Center(
                      child: Text(
                        "❌ ${state.message}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const Center(
                    child: Text("اختر الفرع ثم التصنيف لعرض الوجبات 🍽️"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
