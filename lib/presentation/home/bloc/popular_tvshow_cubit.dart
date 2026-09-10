import 'package:cinelens/common/bloc/generic_cubit.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';
import 'package:cinelens/domain/usecases/get_tvshow_popular.dart';
import 'package:cinelens/service_locator.dart';

class PopularTvshowCubit extends BaseCubit<List<TvShowEntity>> {
  PopularTvshowCubit();

  Future<void> getTrendingTvShows() async {
    await execute(() => getIt<GetTvshowPopularUseCase>().call());
  }
}
