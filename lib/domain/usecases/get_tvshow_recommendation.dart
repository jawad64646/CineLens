import 'package:cinelens/core/usecase/usecase.dart';
import 'package:cinelens/data/data_source/tvshow_api_service.dart';

import 'package:cinelens/domain/entities/tv_show_entity.dart';

import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetTvshowRecommendationUseCase
    extends UseCase<Either<String, List<TvShowEntity>>, String?> {
  @override
  Future<Either<String, List<TvShowEntity>>> call({String? params}) async {
    // TODO: implement call
    return await getIt<TvshowApiService>().getRecommendationBytv(params);
  }
}
