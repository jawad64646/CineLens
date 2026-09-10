import 'package:cinelens/core/usecase/usecase.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';

import 'package:cinelens/domain/repository/movie_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class SimilarMovieUseCase
    extends UseCase<Either<String, List<MovieEntity>>, String?> {
  @override
  Future<Either<String, List<MovieEntity>>> call({String? params}) async {
    // TODO: implement call
    return await getIt<MovieRepository>().getSimilarBymovie(params);
  }
}
