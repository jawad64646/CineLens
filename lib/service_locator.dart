import 'package:cinelens/core/network/dio_client.dart';
import 'package:cinelens/data/data_source/auth_api_service.dart';
import 'package:cinelens/data/data_source/movie_api_service.dart';
import 'package:cinelens/data/data_source/tvshow_api_service.dart';
import 'package:cinelens/data/repository_impl/auth_repository_impl.dart';
import 'package:cinelens/data/repository_impl/movie_repository_impl.dart';
import 'package:cinelens/data/repository_impl/tvshow_repository_impl.dart';

import 'package:cinelens/domain/repository/auth_repository.dart';
import 'package:cinelens/domain/repository/movie_repository.dart';
import 'package:cinelens/domain/repository/tvshow_repository.dart';
import 'package:cinelens/domain/usecases/get_tv_trailer.dart';
import 'package:cinelens/domain/usecases/get_tvshow_popular.dart';
import 'package:cinelens/domain/usecases/get_tvshow_recommendation.dart';
import 'package:cinelens/domain/usecases/get_tvshow_similar.dart';

import 'package:cinelens/domain/usecases/is_login.dart';
import 'package:cinelens/domain/usecases/keyword_tvshow.dart';
import 'package:cinelens/domain/usecases/now_playing.dart';
import 'package:cinelens/domain/usecases/recommendations_movie.dart';
import 'package:cinelens/domain/usecases/search/getmovie_byquery.dart';
import 'package:cinelens/domain/usecases/search/gettvshows_byquery.dart';
import 'package:cinelens/domain/usecases/sign_in.dart';
import 'package:cinelens/domain/usecases/sign_up.dart';
import 'package:cinelens/domain/usecases/similar_movie.dart';
import 'package:cinelens/domain/usecases/trailer_movie.dart';
import 'package:cinelens/domain/usecases/trending_movies.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // dio
  getIt.registerSingleton<DioClient>(DioClient());

  // service
  getIt.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  getIt.registerSingleton<MovieApiService>(MovieApiServiceImpl());
  getIt.registerSingleton<TvshowApiService>(TvshowApiServiceImpl());

  // repository
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl());
  getIt.registerSingleton<TvshowRepository>(TvshowRepositoryImpl());

  // use case
  getIt.registerSingleton<SignInUseCase>(SignInUseCase());
  getIt.registerSingleton<SignUpUseCase>(SignUpUseCase());
  getIt.registerSingleton<IsLoginUseCase>(IsLoginUseCase());
  getIt.registerSingleton<GetTrendingmoviesUseCase>(GetTrendingmoviesUseCase());
  getIt.registerSingleton<NowPlayingUseCase>(NowPlayingUseCase());
  getIt.registerSingleton<GetTvshowPopularUseCase>(GetTvshowPopularUseCase());
  getIt.registerSingleton<GetTrailerUseCase>(GetTrailerUseCase());
  getIt.registerSingleton<SimilarMovieUseCase>(SimilarMovieUseCase());
  getIt.registerSingleton<RecommendationsMovieUseCase>(
    RecommendationsMovieUseCase(),
  );
  getIt.registerSingleton<KeywordTvshowUseCase>(KeywordTvshowUseCase());
  getIt.registerSingleton<GetTvshowRecommendationUseCase>(
    GetTvshowRecommendationUseCase(),
  );
  getIt.registerSingleton<GetTvshowSimilarUseCase>(GetTvshowSimilarUseCase());
  getIt.registerSingleton<GetTvTrailerUseCase>(GetTvTrailerUseCase());
  getIt.registerSingleton<GetmovieByqueryUseCase>(GetmovieByqueryUseCase());
  getIt.registerSingleton<GettvshowsByqueryUseCase>(GettvshowsByqueryUseCase());
}
