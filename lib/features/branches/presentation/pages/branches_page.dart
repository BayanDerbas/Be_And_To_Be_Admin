import 'package:be_and_to_be_admin/config/animations/loading.dart';
import 'package:be_and_to_be_admin/core/constants/app_images.dart';
import 'package:be_and_to_be_admin/core/networks/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart' as di;
import '../../../branches/presentation/cubits/get_branches/branch_cubit.dart';
import '../widgets/custom_branches_header_row.dart';
import '../widgets/custom_branches_tile.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BranchCubit>(
      create: (_) => di.sl<BranchCubit>()..fetchBranches(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.smooky,
              title: Align(
                alignment: Alignment.centerRight,
                child: const Text(
                  'الفروع',
                  style: TextStyle(color: AppColors.amber),
                ),
              ),
            ),
            body: Column(
              children: [
                const CustomBranchesHeaderRow(),
                Expanded(
                  child: BlocBuilder<BranchCubit, BranchState>(
                    builder: (context, state) {
                      if (state is BranchLoading) {
                        return const Center(child: LoadinDount());
                      } else if (state is BranchSuccess) {
                        final branches = state.branches.branches;
                        return ListView.builder(
                          itemCount: branches.length,
                          itemBuilder: (context, index) {
                            final branch = branches[index];
                            return CustomBranchesTile(
                              name: branch.branch_name ?? '',
                              phones: branch.phonenumbers.map((p) => p.phone ?? '').join('\n'),
                              image: '${ApiConstant.imageBase}${branch.image}' ?? '',
                            );
                          },
                        );
                      } else if (state is BranchesFailure) {
                        return Center(
                          child: Text(
                            "Failed to load branches: ${state.message}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return const Center(child: Text("No branches found"));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}