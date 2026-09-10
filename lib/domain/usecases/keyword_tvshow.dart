import 'package:cinelens/core/usecase/usecase.dart';
import 'package:cinelens/domain/entities/keyword_tvshow.dart';
import 'package:cinelens/domain/repository/tvshow_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class KeywordTvshowUseCase
    extends UseCase<Either<String, List<KeywordTvshowEntity>>, String?> {
  @override
  Future<Either<String, List<KeywordTvshowEntity>>> call({
    String? params,
  }) async {
    // TODO: implement call
    return await getIt<TvshowRepository>().getKeywordsTVshow(params);
  }
}
