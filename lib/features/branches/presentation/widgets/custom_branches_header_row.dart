import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomBranchesHeaderRow extends StatelessWidget {
  const CustomBranchesHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.smooky2,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          _HeaderCell(flex: 4, title: "اسم الفرع"),
          _HeaderCell(flex: 4, title: "أرقام الهواتف"),
          _HeaderCell(flex: 4, title: "صورة الفرع"),
          _HeaderCell(flex: 3, title: "التواصل الاجتماعي"),
          _HeaderCell(flex: 2, title: "الموقع"),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final int flex;
  final String title;
  const _HeaderCell({required this.flex, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
