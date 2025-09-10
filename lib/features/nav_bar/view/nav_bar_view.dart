import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/features/home/view/home_view.dart';
import 'package:jr_case_boilerplate/features/nav_bar/widgets/custom_nav_bar_item.dart';
import 'package:jr_case_boilerplate/features/profile/view/profile_view.dart';
import 'package:jr_case_boilerplate/l10n/app_localizations.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int _selectedIndex = 0;
  final List<Widget> _views = [const HomeView(), const ProfileView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex],
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
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            backgroundColor: Colors.transparent,

            unselectedItemColor: Colors.transparent,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(fontSize: 11),
            elevation: 0,
            items: [
              CustomNavItem(
                iconData: 0 == _selectedIndex
                    ? 'assets/images/Home-fill.png'
                    : 'assets/images/Home.png',
                label: AppLocalizations.of(context)!.home,
                index: 0,
                selectedIndex: _selectedIndex,
                context: context,
              ).build(),
              CustomNavItem(
                iconData: 1 == _selectedIndex
                    ? 'assets/images/Profile-fill.png'
                    : 'assets/images/Profile.png',
                label: AppLocalizations.of(context)!.profile,
                index: 1,
                selectedIndex: _selectedIndex,
                context: context,
              ).build(),
            ],
          ),
        ),
      ),
    );
  }
}
