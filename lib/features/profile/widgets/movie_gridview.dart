import 'package:flutter/widgets.dart';
import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/features/profile/widgets/profile_movie_card.dart';

class MovieGridView extends StatelessWidget {
  const MovieGridView({required this.movies, super.key});
  final List<MovieModel> movies;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ProfileMovieCard(movie: movies[index]);
        },
      ),
    );
  }
}
