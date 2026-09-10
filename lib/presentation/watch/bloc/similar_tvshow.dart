import 'package:cinelens/common/bloc/generic_cubit.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';

import 'package:cinelens/domain/usecases/get_tvshow_similar.dart';

import 'package:cinelens/service_locator.dart';

class SimilarTvshowCubit extends BaseCubit<List<TvShowEntity>> {
  SimilarTvshowCubit();

  Future<void> getTvshowSimilar(String? iD) async {
    await execute(() => getIt<GetTvshowSimilarUseCase>().call(params: iD));
  }
}
