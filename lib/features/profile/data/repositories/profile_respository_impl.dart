import 'package:jr_case_boilerplate/core/models/movie_model.dart';
import 'package:jr_case_boilerplate/core/services/local_datasource.dart';
import 'package:jr_case_boilerplate/features/auth/data/models/user_model.dart';
import 'package:jr_case_boilerplate/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:jr_case_boilerplate/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRespositoryImpl(
    ref.read(LocalDataSourceProvider),
    ref.read(profileRemoteDataSourceProvider),
  );
});

class ProfileRespositoryImpl implements ProfileRepository {
  ProfileRespositoryImpl(this._localDataSource, this._profileRemoteDatasource);
  final ProfileRemoteDatasource _profileRemoteDatasource;
  final LocalDataSource _localDataSource;
  @override
  Future<List<MovieModel>> getFavoriteMovie() async {
    try {
      final response = await _profileRemoteDatasource.getFavoriteMovie(
        await _localDataSource.getCachedToken(),
      );

      if (response.response.code == 200 && response.data != null) {
        return response.data;
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
  Future<UserModel?> getCachedUser() async {
    try {
      return await _localDataSource.getCachedUser();
    } catch (e) {
      return null;
    }
  }
}
