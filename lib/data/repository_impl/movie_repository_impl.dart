import 'package:cinelens/common/widgets/trailer_entity.dart';
import 'package:cinelens/data/data_source/movie_api_service.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';

import 'package:cinelens/domain/repository/movie_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository {
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Future<Either<String, List<String>>> getTrendingMovies() async {
    final result = await getIt<MovieApiService>().getTrendingMovies();

    return result.fold((l) => Left(l), (movies) {
      final imageList = movies
          .map((movie) => '$_imageBaseUrl${movie.posterPath}')
          .toList();
      return Right(imageList);
    });
  }

  @override
  Future<Either<String, List<MovieEntity>>> getNowPlaying() async {
    // TODO: implement getNowPlaying
    return await getIt<MovieApiService>().getNowPlaying();
  }

  @override
  Future<Either<String, TrailerEntity>> getMovieTrailer(String? id) async {
    // TODO: implement getMovieTrailer
    return await getIt<MovieApiService>().getMovieTrailer(id);
  }

  @override
  Future<Either<String, List<MovieEntity>>> getRecommendationBymovie(
    String? id,
  ) async {
    // TODO: implement getRecommendationBymovie
    return await getIt<MovieApiService>().getRecommendationBymovie(id);
  }

  @override
  Future<Either<String, List<MovieEntity>>> getSimilarBymovie(
    String? id,
  ) async {
    // TODO: implement getSimilarBymovie
    return await getIt<MovieApiService>().getSimilarBymovie(id);
  }

  @override
  Future<Either<String, List<MovieEntity>>> getMoviesByquery(
    String query,
  ) async {
    // TODO: implement getMoviesByquery
    return await getIt<MovieApiService>().getMoviesByquery(query);
  }
}
