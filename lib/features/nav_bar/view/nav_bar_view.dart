import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/features/home/view/home_view.dart';
import 'package:jr_case_boilerplate/features/nav_bar/providers/navbar_index_provider.dart';
import 'package:jr_case_boilerplate/features/nav_bar/widgets/custom_nav_bar_item.dart';
import 'package:jr_case_boilerplate/features/profile/view/profile_view.dart';
import 'package:jr_case_boilerplate/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBarView extends ConsumerWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navBarIndexProvider);
    final views = const [HomeView(), ProfileView()];
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          // Fade + Slide animasyonu
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0.1, 0.0), // sağdan hafif gelsin
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(selectedIndex),
          child: views[selectedIndex],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.grey[900]),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.gradientBlack.withOpacity(0.9),
                AppColors.gradientBlack,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (value) =>
                ref.read(navBarIndexProvider.notifier).state = value,
            backgroundColor: Colors.transparent,

            unselectedItemColor: Colors.transparent,
            selectedLabelStyle: Theme.of(context).textTheme.bodyMedium!
                .copyWith(
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w500,
                ),
            unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!
                .copyWith(
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w500,
                ),
            elevation: 0,
            items: [
              CustomNavItem(
                iconData: 0 == selectedIndex
                    ? 'assets/images/Home-fill.png'
                    : 'assets/images/Home.png',
                label: AppLocalizations.of(context)!.home,
                index: 0,
                selectedIndex: selectedIndex,
                context: context,
              ).build(),
              CustomNavItem(
                iconData: 1 == selectedIndex
                    ? 'assets/images/Profile-fill.png'
                    : 'assets/images/Profile.png',
                label: AppLocalizations.of(context)!.profile,
                index: 1,
                selectedIndex: selectedIndex,
                context: context,
              ).build(),
            ],
          ),
        ),
      ),
    );
  }
}
