import 'package:cinelens/common/widgets/trailer_entity.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<String, List<String>>> getTrendingMovies();
  Future<Either<String, List<MovieEntity>>> getNowPlaying();
  Future<Either<String, TrailerEntity>> getMovieTrailer(String? id);
  Future<Either<String, List<MovieEntity>>> getRecommendationBymovie(
    String? id,
  );
  Future<Either<String, List<MovieEntity>>> getSimilarBymovie(String? id);
  Future<Either<String, List<MovieEntity>>> getMoviesByquery(String query);
}
