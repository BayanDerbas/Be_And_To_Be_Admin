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
              title: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الفروع',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: Column(
                  children: [
                    const CustomBranchesHeaderRow(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
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
                                final hasValidLocation = branch.length != null &&
                                    branch.width != null &&
                                    branch.length != 0 &&
                                    branch.width != 0;

                                final locationUrl = hasValidLocation
                                    ? 'https://maps.google.com/?q=${branch.length},${branch.width}'
                                    : '';

                                return CustomBranchesTile(
                                  name: branch.branch_name ?? '',
                                  phones: branch.phonenumbers.map((p) => p.phone ?? '').join('\n'),
                                  image: '${ApiConstant.imageBase}${branch.image}' ?? '',
                                  socialmediaInstagram: branch.instagramtoken ?? '',
                                  socialmediaFacebook: branch.facebooktoken ?? '',
                                  location: locationUrl,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
