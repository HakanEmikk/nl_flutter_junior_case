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
  final String prefixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool isPasswordVisible;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.baseWhite.withOpacity(0.05),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.baseWhite.withOpacity(0.20),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: isPassword && isPasswordVisible,
                onChanged: (value) {
                  fieldState.didChange(value);
                },
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.baseWhite.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 12),
                    child: ImageIcon(
                      AssetImage(prefixIcon),
                      color: AppColors.baseWhite,
                      size: 24,
                    ),
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
                            child: ImageIcon(
                              AssetImage(suffixIcon!),
                              color: AppColors.baseWhite.withOpacity(0.3),
                              size: 24,
                            ),
                          ),
                        )
                      : null,
                  suffixIconConstraints: suffixIcon != null
                      ? const BoxConstraints(minWidth: 48, minHeight: 20)
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 12),
                child: Text(
                  fieldState.errorText ?? '',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
