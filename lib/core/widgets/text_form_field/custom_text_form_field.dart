import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    super.key,
    this.keyboardType,
    this.isPassword = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.isPasswordVisible = false,
    this.validator,
  });
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool isPasswordVisible;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.baseWhite.withOpacity(0.05), // %5 beyaz ton
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.baseWhite.withOpacity(0.20), // %20 beyaz border
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isPassword && isPasswordVisible,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.baseWhite,
          fontWeight: FontWeight.w400,
        ),

        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: AppColors.primary, // %40 beyaz border
              width: 1,
            ),
          ),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: Icon(prefixIcon, color: AppColors.baseWhite, size: 20),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 20,
          ),
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 12),
                    child: Icon(
                      suffixIcon,
                      color: AppColors.baseWhite.withOpacity(0.3),
                      size: 24,
                    ),
                  ),
                )
              : null,
          suffixIconConstraints: suffixIcon != null
              ? const BoxConstraints(minWidth: 48, minHeight: 20)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          isDense: true,
        ),
      ),
    );
  }
}
