import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/network/dio_provider.dart';
import 'package:jr_case_boilerplate/features/profile/data/models/profile_movie_response.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDatasource>((
  ref,
) {
  return ProfileRemoteDatasource(ref.read(dioProvider));
});

class ProfileRemoteDatasource {
  ProfileRemoteDatasource(this._dio);
  final Dio _dio;
  Future<ProfileMovieResponse> getFavoriteMovie(String? token) async {
    try {
      final response = await _dio.get(
        'movie/favorites',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final profileResponse = ProfileMovieResponse.fromJson(response.data);

      return profileResponse;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Beklenmeyen hata oluştu');
    } catch (e) {
      rethrow;
    }
  }
}
