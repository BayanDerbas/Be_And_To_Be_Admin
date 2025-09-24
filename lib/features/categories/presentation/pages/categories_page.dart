import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart' as di;
import '../cubits/categories_cubit.dart';
import '../widgets/CustomCategoriesHeaderRow.dart';
import '../widgets/CustomCategoriesTile.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CategoriesCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.smooky,
              title: const Text(
                'Categories',
                style: TextStyle(color: AppColors.amber),
              ),
            ),
            body: Column(
              children: [
                const CustomCategoriesHeaderRow(),
                Expanded(
                  child: BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesSuccess) {
                        final categories = state.categories;
                        return ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return CustomCategoriesTile(
                              name: category['name'] ?? '',
                              image: category['image'] ?? 'assets/images/pizza.png',
                              branch: category['branch'] ?? '',
                            );
                          },
                        );
                      }
                      return const Center(
                        child: Text("Main Categories🥪"),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}