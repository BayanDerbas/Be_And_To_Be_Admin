import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/networks/api_constant.dart';
import '../../domain/entities/meal_type_entity.dart';
import '../cubits/meal_types_cubit/meal_types_cubit.dart';

class MealTypesDialog extends StatelessWidget {
  final String mealName;
  final String mealImage;

  const MealTypesDialog({
    super.key,
    required this.mealName,
    required this.mealImage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.smooky2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: CachedNetworkImageProvider(
              '${ApiConstant.imageBase}$mealImage',
            ),
            backgroundColor: Colors.grey[800],
          ),
          const SizedBox(height: 12),
          Text(
            mealName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        height: 250,
        child: BlocBuilder<MealTypesCubit, MealTypesState>(
          builder: (context, state) {
            if (state is MealTypesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MealTypesSuccess) {
              final List<MealTypeEntity> types =
                  state.meals
                      .expand((meal) => meal.types ?? [])
                      .cast<MealTypeEntity>()
                      .toList();

              if (types.isEmpty) {
                return const Center(
                  child: Text(
                    "لا يوجد أنواع متاحة لهذه الوجبة",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                itemCount: types.length,
                separatorBuilder:
                    (_, __) => const Divider(color: AppColors.grey1),
                itemBuilder: (context, index) {
                  final type = types[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.smooky2,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.grey1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          type.available == 1
                              ? Icons.check_circle
                              : Icons.cancel,
                          color:
                              type.available == 1 ? Colors.green : Colors.red,
                          size: 20,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      backgroundColor: AppColors.smooky2,
                                      title: Text(
                                        "تعديل حالة ${type.name}",
                                        style: const TextStyle(
                                          color: AppColors.amber,
                                        ),
                                      ),
                                      content: const Text(
                                        "هل تريد تعديل حالة هذه الوجبة؟",
                                        style: TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            context
                                                .read<MealTypesCubit>()
                                                .makeUnavailable(type.id);
                                            context.pop();
                                            ScaffoldMessenger.of(context,).showSnackBar(
                                              const SnackBar(
                                                content: Text("تم تعديل حالة نوع الوجبة بنجاح",),
                                              ),
                                            );
                                          },
                                          child: const Text("تأكيد",
                                            style: TextStyle(color: AppColors.white,),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => context.pop(),
                                          child: const Text(
                                            "إلغاء",
                                            style: TextStyle(
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                        ),
                        Expanded(
                          flex: 3,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type.name,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    if (type.price > 0)
                                      Text(
                                        "السعر: ${type.price} ل.س",
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    if (type.supportprice > 0) ...[
                                      const SizedBox(width: 8),
                                      Text(
                                        "مدعومة: ${type.supportprice} ل.س",
                                        style: const TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is MealTypesFailure) {
              return Text(
                "❌ ${state.message}",
                style: const TextStyle(color: Colors.red),
              );
            }
            return const SizedBox();
          },
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: AppColors.amber),
          child: const Text(
            "إغلاق",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
