class MovieModel {
  final String id;
  final String title;
  final String year;
  final String poster;
  final String genre;
  final String imdbRating;
  final List<String>? Images;
  bool? isFavorite;
  final String? plot;
  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.poster,
    required this.genre,
    required this.imdbRating,
    required this.Images,
    required this.isFavorite,
    required this.plot,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? '',
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      genre: json['Genre'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      Images: (json['Images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFavorite: json['isFavorite'] ?? false,
      plot: json['Plot'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Title': title,
      'Year': year,
      'Poster': poster,
      'Genre': genre,
      'imdbRating': imdbRating,
      'Images': Images,
      'isFavorite': isFavorite,
      'Plot': plot,
    };
  }
}
