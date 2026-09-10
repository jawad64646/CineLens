import 'package:cinelens/common/widgets/trailer_entity.dart';
import 'package:cinelens/domain/entities/keyword_tvshow.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TvshowRepository {
  Future<Either<String, List<TvShowEntity>>> getPopularTvShows();
  Future<Either<String, List<KeywordTvshowEntity>>> getKeywordsTVshow(
    String? id,
  );
  Future<Either<String, List<TvShowEntity>>> getRecommendationBytv(String? id);
  Future<Either<String, List<TvShowEntity>>> getSimilarBytv(String? id);
  Future<Either<String, TrailerEntity>> getTvTrailer(String? id);
  Future<Either<String, List<TvShowEntity>>> getTvshowsByquery(String query);
}
