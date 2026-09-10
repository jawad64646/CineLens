import 'package:cinelens/common/bloc/generic_cubit.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';
import 'package:cinelens/domain/usecases/recommendations_movie.dart';
import 'package:cinelens/service_locator.dart';

class RecommendationMovieCubit extends BaseCubit<List<MovieEntity>> {
  RecommendationMovieCubit();

  Future<void> getRecommendationsMovie(String? iD) async {
    await execute(() => getIt<RecommendationsMovieUseCase>().call(params: iD));
  }
}
