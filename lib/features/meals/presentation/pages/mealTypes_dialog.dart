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
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        final dialogWidth = maxWidth < 600
            ? maxWidth * 0.9
            : maxWidth < 1000
            ? 500.0
            : 600.0;

        // 🔹 Make dialog shorter
        final dialogHeight = maxHeight < 700 ? maxHeight * 0.45 : 320.0;

        return AlertDialog(
          backgroundColor: AppColors.smooky,
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: AppColors.amber, width: 1.5),
          ),
          title: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage:
                CachedNetworkImageProvider('${ApiConstant.imageBase}$mealImage'),
                backgroundColor: Colors.grey[800],
              ),
              const SizedBox(height: 10),
              Text(
                mealName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: dialogWidth,
            height: dialogHeight,
            child: BlocBuilder<MealTypesCubit, MealTypesState>(
              builder: (context, state) {
                if (state is MealTypesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealTypesSuccess) {
                  final types = state.meals
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
                    padding: const EdgeInsets.all(8),
                    itemCount: types.length,
                    separatorBuilder: (_, __) =>
                    const Divider(color: AppColors.grey1),
                    itemBuilder: (context, index) {
                      final type = types[index];
                      final isAvailable = type.available == 1;

                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.smooky2,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.grey1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🔹 Text on the right
                              Expanded(
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
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: [
                                        if (type.price > 0)
                                          Text(
                                            "السعر: ${type.price} ل.س",
                                            style: const TextStyle(
                                              color: AppColors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        if (type.supportprice > 0)
                                          Text(
                                            "مدعومة: ${type.supportprice} ل.س",
                                            style: const TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 12,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // 🔹 Icons on the left
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: AppColors.white,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            backgroundColor: AppColors.smooky,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              side: const BorderSide(
                                                color: AppColors.amber,
                                                width: 1.5,
                                              ),
                                            ),
                                            title: Text(
                                              isAvailable
                                                  ? "تعطيل ${type.name}"
                                                  : "تفعيل ${type.name}",
                                              style: const TextStyle(
                                                  color: AppColors.white),
                                            ),
                                            content: Text(
                                              isAvailable
                                                  ? "هل تريد جعل هذا النوع غير متاح؟"
                                                  : "هل تريد جعله متاحًا؟",
                                              style: const TextStyle(
                                                  color: AppColors.white),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  if (isAvailable) {
                                                    await context
                                                        .read<MealTypesCubit>()
                                                        .makeUnavailable(type.id);
                                                  } else {
                                                    await context
                                                        .read<MealTypesCubit>()
                                                        .makeAvailable(type.id);
                                                  }
                                                  context.pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        isAvailable
                                                            ? "تم تعطيل النوع بنجاح"
                                                            : "تم تفعيل النوع بنجاح",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  "تأكيد",
                                                  style: TextStyle(
                                                      color: AppColors.white),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () => context.pop(),
                                                child: const Text(
                                                  "إلغاء",
                                                  style: TextStyle(
                                                      color: AppColors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Icon(
                                    isAvailable
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: isAvailable
                                        ? Colors.green
                                        : Colors.redAccent,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
              onPressed: () => context.pop(),
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
      },
    );
  }
}
