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
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(movieProvider.notifier).fetchMovies());
  }

  @override
  Widget build(BuildContext context) {
    final movieState = ref.watch(movieProvider);

    return Scaffold(
      body: Stack(
        children: [
          movieState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : PageView.builder(
                  itemCount: movieState.movies.length,
                  scrollDirection: Axis.vertical,

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
        ],
      ),
    );
  }
}
