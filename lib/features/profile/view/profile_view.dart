import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/routes/app_routes.dart';
import 'package:jr_case_boilerplate/core/widgets/bottom_sheet/offer_bottom_sheet.dart';
import 'package:jr_case_boilerplate/features/profile/providers/profile_provider.dart';
import 'package:jr_case_boilerplate/features/profile/widgets/movie_gridview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/l10n/app_localizations.dart';
import 'package:jr_case_boilerplate/main.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    ref.read(profileProvider.notifier).fetchFavoriteMovies();
    super.didPopNext();
  }

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
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.profile,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: AppColors.baseWhite,
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        GestureDetector(
                          onTap: () {
                            showCustomBottomSheet(context);
                          },
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
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ImageIcon(
                                    AssetImage('assets/images/Gem.png'),
                                    color: AppColors.baseWhite,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    AppLocalizations.of(context)!.limitedOffer,
                                    style: const TextStyle(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: profileState.user?.photoUrl != null
                              ? NetworkImage(profileState.user!.photoUrl!)
                              : null,
                          child: profileState.user?.photoUrl == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        const SizedBox(width: 10),
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
                              "${AppLocalizations.of(context)!.userId} ${profileState.user?.id ?? ""}",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: AppColors.baseWhite.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),

                        GestureDetector(
                          onTap: () {
                            AppRoutes.pushNamed(context, AppRoutes.imageUpload);
                          },
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
                              AppLocalizations.of(context)!.addPhoto,
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
                    AppLocalizations.of(context)!.favorites,
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
