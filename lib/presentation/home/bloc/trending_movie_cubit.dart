import 'package:cinelens/common/bloc/generic_cubit.dart';
import 'package:cinelens/domain/usecases/trending_movies.dart';
import 'package:cinelens/service_locator.dart';

class TrendingMovieCubit extends BaseCubit<List<String>> {
  TrendingMovieCubit();

  Future<void> getTrendingMovies() async {
    await execute(() => getIt<GetTrendingmoviesUseCase>().call());
  }
}
