import 'package:cinelens/common/bloc/generic_cubit.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';
import 'package:cinelens/domain/usecases/get_tvshow_recommendation.dart';
import 'package:cinelens/service_locator.dart';

class RecommendationTvshowsCubit extends BaseCubit<List<TvShowEntity>> {
  RecommendationTvshowsCubit();

  Future<void> getTvshowRecommendation(String? iD) async {
    await execute(
      () => getIt<GetTvshowRecommendationUseCase>().call(params: iD),
    );
  }
}
