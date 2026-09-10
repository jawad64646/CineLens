import 'package:cinelens/core/usecase/usecase.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';

import 'package:cinelens/domain/repository/tvshow_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetTvshowPopularUseCase
    extends UseCase<Either<String, List<TvShowEntity>>, dynamic> {
  @override
  Future<Either<String, List<TvShowEntity>>> call({params}) async {
    // TODO: implement call
    return await getIt<TvshowRepository>().getPopularTvShows();
  }
}
