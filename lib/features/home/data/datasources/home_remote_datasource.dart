import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/network/dio_provider.dart';
import 'package:jr_case_boilerplate/features/home/data/models/movie_response.dart';

final homeRemoteDataSourceProvider = Provider<HomeRemoteDatasource>((ref) {
  return HomeRemoteDatasource(ref.read(dioProvider));
});

class HomeRemoteDatasource {
  HomeRemoteDatasource(this._dio);
  final Dio _dio;

  Future<MovieResponse> getMovie(String? token) async {
    try {
      final response = await _dio.get(
        'movie/list',
        queryParameters: {'page': 1},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final homeResponse = MovieResponse.fromJson(response.data);

      return homeResponse;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Beklenmeyen hata oluştu');
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieResponse> setFavoriteMovie(String? token, String id) async {
    try {
      final response = await _dio.post(
        'movie/favorite/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final homeResponse = MovieResponse.fromJson(response.data);
      return homeResponse;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Beklenmeyen hata oluştu');
    } catch (e) {
      rethrow;
    }
  }
}
