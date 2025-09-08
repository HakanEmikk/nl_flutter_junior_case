import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/core/models/response_info.dart';

class ProfileMovieResponse {
  ProfileMovieResponse({required this.response, required this.data});
  factory ProfileMovieResponse.fromJson(Map<String, dynamic> json) {
    return ProfileMovieResponse(
      response: ResponseInfo.fromJson(json['response']),
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
  final ResponseInfo response;
  final List<MovieModel> data;
}
