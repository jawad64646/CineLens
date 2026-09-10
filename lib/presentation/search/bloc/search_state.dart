import 'package:cinelens/domain/entities/movie_entity.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';

class SearchState {}

class InitialSearchState extends SearchState {}

class LoadingDataState extends SearchState {}

class LoadedMovieState extends SearchState {
  final List<MovieEntity> movies;

  LoadedMovieState({required this.movies});
}

class LoadedTvShowsState extends SearchState {
  final List<TvShowEntity> tvShows;

  LoadedTvShowsState({required this.tvShows});
}

class FailedSearchState extends SearchState {
  final String message;
  FailedSearchState({required this.message});
}
