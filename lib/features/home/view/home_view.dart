import 'package:flutter/material.dart';

import 'package:jr_case_boilerplate/features/home/providers/movie_provider.dart';
import 'package:jr_case_boilerplate/features/home/widgets/home_movie_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.microtask(() => ref.read(movieProvider.notifier).fetchMovies());
    _pageController.addListener(_onScroll);
  }

  void _onScroll() {
    final movieState = ref.read(movieProvider);

    if (_pageController.page != null &&
        _pageController.page! >= movieState.movies.length - 2 &&
        !movieState.isLoading &&
        !movieState.isLoadingMore) {
      ref.read(movieProvider.notifier).fetchMovies(loadMore: true);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieState = ref.watch(movieProvider);

    return Scaffold(
      body: Stack(
        children: [
          if (movieState.isLoading && movieState.movies.isEmpty)
            const Center(child: CircularProgressIndicator())
          else if (movieState.movies.isNotEmpty)
            Stack(
              children: [
                PageView.builder(
                  itemCount: movieState.movies.length,
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return HomeMovieListItem(
                      movie: movieState.movies[index],
                      isActive: true,
                      onFavoriteToggle: () {
                        ref
                            .read(movieProvider.notifier)
                            .setFavoriteMovie(movieState.movies[index].id);
                      },
                    );
                  },
                ),
                if (movieState.isLoadingMore)
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white24,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
