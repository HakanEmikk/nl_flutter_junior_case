import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    super.key,

    this.onTap,
    this.size = 60.0,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.assetIcon,
  });

  final VoidCallback? onTap;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final String? assetIcon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.baseWhite.withOpacity(0.2),
          width: 1,
        ),
        color: backgroundColor ?? Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Center(
            child: Image.asset(
              assetIcon!,
              width: iconSize ?? size * 0.4,
              height: iconSize ?? size * 0.4,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
