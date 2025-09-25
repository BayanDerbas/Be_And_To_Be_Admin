import 'package:be_and_to_be_admin/config/animations/loading.dart';
import 'package:be_and_to_be_admin/core/networks/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart' as di;
import '../../../branches/data/models/branch_model.dart';
import '../../../branches/domain/entities/branch_entity.dart';
import '../../../branches/presentation/cubits/get_branches/branch_cubit.dart';
import '../cubits/categories_cubit.dart';
import '../widgets/CustomCategoriesHeaderRow.dart';
import '../widgets/CustomCategoriesTile.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  BranchEntity? selectedBranch;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CategoriesCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.smooky,
          title: Align(
            alignment: Alignment.centerRight,
            child: const Text(
              'الأصناف',
              style: TextStyle(
                color: AppColors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        body: Column(
          children: [
            BlocBuilder<BranchCubit, BranchState>(
              builder: (context, branchState) {
                if (branchState is BranchLoading) {
                  return const Center(child: Text(''));
                } else if (branchState is BranchSuccess) {
                  final branches = branchState.branches.branches;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          hint: Text(
                            "اختر الفرع",
                            style: TextStyle(color: AppColors.amber),
                            textAlign: TextAlign.right,
                          ),
                          isExpanded: true,
                          dropdownColor: AppColors.smooky2,
                          underline: const SizedBox(),
                          style: const TextStyle(color: AppColors.white),
                          items: branches.map((branch) {
                            return DropdownMenuItem(
                              value: branch,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  branch.branch_name ?? "Unnamed",
                                  style: const TextStyle(color: AppColors.amber),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (branch) {
                            setState(() {
                              selectedBranch = branch;
                            });
                            if (branch != null) {
                              context.read<CategoriesCubit>().fetchCategories(branch.id);
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

            const CustomCategoriesHeaderRow(),

            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesSuccess) {
                    final categories = state.categories;

                    final branchState = context.watch<BranchCubit>().state;
                    final branches = branchState is BranchSuccess
                        ? branchState.branches.branches
                        : <BranchEntity>[];

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];

                        final branch = branches.firstWhere(
                              (b) => b.id == category.branch_id,
                          orElse: () => BranchModel(
                            id: -1,
                            branch_name: "Unknown Branch",
                            image: null,
                            length: null,
                            width: null,
                            facebooktoken: null,
                            instagramtoken: null,
                            created_at: null,
                            updated_at: null,
                            phonenumbers: [],
                          ),
                        );


                        return CustomCategoriesTile(
                          name: category.name,
                          image: '${ApiConstant.imageBase}${category.image}',
                          branch: branch.branch_name ?? "Unknown Branch",
                        );
                      },
                    );
                  } else if (state is CategoriesFailure) {
                    return Center(child: Text("❌ ${state.message}"));
                  }
                  return const Center(
                    child: Text("Main Categories🥪"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
