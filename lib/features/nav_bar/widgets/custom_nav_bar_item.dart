import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';

class CustomNavItem {
  final IconData iconData;
  final String label;
  final int index;
  final int selectedIndex;
  final Color selectedColor;
  final Color unselectedColor;
  BuildContext context;

  CustomNavItem({
    required this.iconData,
    required this.label,
    required this.index,
    required this.selectedIndex,
    this.selectedColor = Colors.red,
    this.unselectedColor = Colors.grey,
    required this.context,
  });

  BottomNavigationBarItem build() {
    bool isSelected = index == selectedIndex;

    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
        width: 169,
        height: 48,
        decoration: BoxDecoration(
          gradient: isSelected
              ? RadialGradient(
                  colors: [
                    AppColors.navBarItemgraientColor,
                    AppColors.navBarItemgraientColor2,
                  ],
                  center: Alignment.topCenter, // Üstten başlasın
                  radius: 2.0,
                  stops: [0.0, 0.7],
                )
              : null,
          color: isSelected ? selectedColor : Colors.transparent,
          border: Border.all(color: AppColors.baseWhite.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(42),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: isSelected ? Colors.white : unselectedColor,
              size: 20,
            ),

            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.baseWhite),
            ),
          ],
        ),
      ),
      label: '',
    );
  }
}
