import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Color borderColor;
  final bool obscureText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.borderColor = AppColors.white,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textAlign: TextAlign.right,
      style: const TextStyle(color: AppColors.white),

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.grey1.withOpacity(0.7)),

        filled: true,
        fillColor: AppColors.smooky2,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.amber)
            : null,

        suffixIcon: suffixIcon,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.white, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}