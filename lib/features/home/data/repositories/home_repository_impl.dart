import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/services/local_datasource.dart';
import 'package:jr_case_boilerplate/features/home/data/datasources/home_remote_datasource.dart';
import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/features/home/data/repositories/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    ref.read(homeRemoteDataSourceProvider),
    ref.read(LocalDataSourceProvider),
  );
});

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._homeRemoteDatasource, this._localDataSource);
  final HomeRemoteDatasource _homeRemoteDatasource;
  final LocalDataSource _localDataSource;
  @override
  Future<List<MovieModel>> getMovie() async {
    try {
      final response = await _homeRemoteDatasource.getMovie(
        await _localDataSource.getCachedToken(),
      );

      if (response.response.code == 200 && response.data != null) {
        return response.data.movies!;
      } else {
        throw Exception(
          response.response.message.isEmpty
              ? 'Film listesi alınamadı'
              : response.response.message,
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }

  @override
  Future<String?> getCachedToken() async {
    try {
      return await _localDataSource.getCachedToken();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<MovieModel> setFavoriteMovie(String id) async {
    try {
      final response = await _homeRemoteDatasource.setFavoriteMovie(
        await _localDataSource.getCachedToken(),
        id,
      );

      if (response.response.code == 200 && response.data != null) {
        return response.data.movie!;
      } else {
        throw Exception(
          response.response.message.isEmpty
              ? 'Film listesi alınamadı'
              : response.response.message,
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }
}
