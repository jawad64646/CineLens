import 'package:cinelens/common/bloc/generic_cubit.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';
import 'package:cinelens/domain/usecases/similar_movie.dart';
import 'package:cinelens/service_locator.dart';

class SimilarMovieCubit extends BaseCubit<List<MovieEntity>> {
  SimilarMovieCubit();

  Future<void> getSimilarMovies(String? id) async {
    await execute(() => getIt<SimilarMovieUseCase>().call(params: id));
  }
}
