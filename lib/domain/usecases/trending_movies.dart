import 'package:cinelens/core/usecase/usecase.dart';

import 'package:cinelens/domain/repository/movie_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetTrendingmoviesUseCase
    extends UseCase<Either<String, List<String>>, dynamic> {
  @override
  Future<Either<String, List<String>>> call({params}) async {
    // TODO: implement call
    return await getIt<MovieRepository>().getTrendingMovies();
  }
}
