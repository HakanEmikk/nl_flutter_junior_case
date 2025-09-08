import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/features/profile/providers/profile_provider.dart';
import 'package:jr_case_boilerplate/features/profile/widgets/movie_gridview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(profileProvider.notifier).fetchFavoriteMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF2C1810),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profil',
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: AppColors.baseWhite,
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 121,
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.navBarItemgraientColor,
                                  AppColors.bottomSheetButton,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(53),
                            ),
                            child: const Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: AppColors.baseWhite,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Sınırlı Tekıif',
                                    style: TextStyle(
                                      color: AppColors.baseWhite,
                                      fontSize: 12,
                                      fontFamily: "12Px Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundImage: profileState.user?.photoUrl != null
                              ? NetworkImage(profileState.user!.photoUrl!)
                              : null,
                          child: profileState.user?.photoUrl == null
                              ? Icon(Icons.person)
                              : null,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileState.user?.name ?? "",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: AppColors.baseWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              "ID: ${profileState.user?.id ?? ""}",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: AppColors.baseWhite.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),

                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.baseWhite.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Fotoğraf Ekle',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.baseWhite,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // "Beğendiklerim" section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Beğendiklerim',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.baseWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Movie list
              Expanded(child: MovieGridView(movies: profileState.movies)),
            ],
          ),
        ),
      ),
    );
  }
}
