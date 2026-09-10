import 'package:cinelens/common/widgets/trailer_entity.dart';
import 'package:cinelens/data/data_source/tvshow_api_service.dart';
import 'package:cinelens/domain/entities/keyword_tvshow.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';
import 'package:cinelens/domain/repository/tvshow_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class TvshowRepositoryImpl extends TvshowRepository {
  @override
  Future<Either<String, List<TvShowEntity>>> getPopularTvShows() async {
    // TODO: implement getTrendingTvShows
    return await getIt<TvshowApiService>().getPopularTvShows();
  }

  @override
  Future<Either<String, List<KeywordTvshowEntity>>> getKeywordsTVshow(
    String? id,
  ) async {
    // TODO: implement getKeywordsTVshow
    return await getIt<TvshowApiService>().getKeywordsTVshow(id!);
  }

  @override
  Future<Either<String, List<TvShowEntity>>> getRecommendationBytv(
    String? id,
  ) async {
    // TODO: implement getRecommendationBymovie
    return await getIt<TvshowApiService>().getRecommendationBytv(id!);
  }

  @override
  Future<Either<String, List<TvShowEntity>>> getSimilarBytv(String? id) async {
    // TODO: implement getSimilarBymovie
    return await getIt<TvshowApiService>().getSimilarBytv(id!);
  }

  @override
  Future<Either<String, TrailerEntity>> getTvTrailer(String? id) async {
    // TODO: implement getTvTrailer
    return await getIt<TvshowApiService>().getTvTrailer(id);
  }

  @override
  Future<Either<String, List<TvShowEntity>>> getTvshowsByquery(
    String query,
  ) async {
    // TODO: implement getTvshowsByquery
    return await getIt<TvshowApiService>().getTvshowsByquery(query);
  }
}
