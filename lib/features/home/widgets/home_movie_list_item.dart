import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/models/movie_model.dart';

class HomeMovieListItem extends StatefulWidget {
  final MovieModel movie;
  final bool isActive;
  final VoidCallback onFavoriteToggle;

  const HomeMovieListItem({
    Key? key,
    required this.movie,
    required this.isActive,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  State<HomeMovieListItem> createState() => _HomeMovieListItemState();
}

class _HomeMovieListItemState extends State<HomeMovieListItem>
    with TickerProviderStateMixin {
  late AnimationController _contentAnimationController;
  late AnimationController _favoriteAnimationController;
  late Animation<double> _contentAnimation;
  late Animation<double> _favoriteScaleAnimation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _favoriteAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _contentAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    _favoriteScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _favoriteAnimationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _contentAnimationController.dispose();
    _favoriteAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(HomeMovieListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _contentAnimationController.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _contentAnimationController.reverse();
    }
  }

  void _onFavoritePressed() {
    _favoriteAnimationController.forward().then((_) {
      _favoriteAnimationController.reverse();
    });
    widget.onFavoriteToggle();
    setState(() {
      widget.movie.isFavorite = !widget.movie.isFavorite!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          child: Image.network(widget.movie.Images![0], fit: BoxFit.fill),
        ),

        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: widget.isActive
                  ? [Colors.transparent, Colors.black.withOpacity(0.7)]
                  : [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.5),
                    ],
              stops: const [0.4, 1.0],
            ),
          ),
        ),

        // Favori butonu - Animasyonlu
        Positioned(
          bottom: 130,
          right: 20,
          child: AnimatedBuilder(
            animation: _favoriteScaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _favoriteScaleAnimation.value,
                child: GestureDetector(
                  onTap: _onFavoritePressed,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 52,
                    height: 72,
                    decoration: BoxDecoration(
                      color: widget.movie.isFavorite!
                          ? AppColors.black.withOpacity(0.6)
                          : AppColors.black.withOpacity(0.05),
                      border: Border.all(
                        color: widget.movie.isFavorite!
                            ? AppColors.baseWhite.withOpacity(0.6)
                            : AppColors.baseWhite.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [BoxShadow(blurRadius: 15)],
                    ),
                    child: Icon(
                      widget.movie.isFavorite!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.movie.isFavorite!
                          ? AppColors.navBarItemgraientColor
                          : AppColors.baseWhite,
                      size: 24,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Film bilgileri - Slide-in animasyonu
        Positioned(
          left: 20,
          bottom: 80,
          right: 20,
          child: AnimatedBuilder(
            animation: _contentAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, (1 - _contentAnimation.value) * 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Netflix logosu ve film başlığı
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 40,
                          height: 40,

                          child: Image.asset('assets/images/Icon.png'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      color: AppColors.baseWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                child: Text(widget.movie.title),
                              ),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: AppColors.baseWhite.withOpacity(
                                        0.8,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    ),
                                child: Text(
                                  widget.movie.plot!,
                                  maxLines: isExpanded ? null : 3,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              if (widget.movie.plot!.length > 100)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      isExpanded
                                          ? "Daha az göster"
                                          : "Devamını oku",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppColors.baseWhite,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Film bilgileri - Orijinal tasarım
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
