import 'package:jr_case_boilerplate/core/models/response_info.dart';
import 'package:jr_case_boilerplate/features/home/data/models/movie_data.dart';

class MovieResponse {
  MovieResponse({required this.response, required this.data});
  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      response: ResponseInfo.fromJson(json['response']),
      data: MovieData.fromJson(json['data']),
    );
  }
  final ResponseInfo response;
  final MovieData data;
}
