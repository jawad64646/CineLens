import 'package:cinelens/domain/usecases/search/getmovie_byquery.dart';
import 'package:cinelens/domain/usecases/search/gettvshows_byquery.dart';
import 'package:cinelens/presentation/search/bloc/search_state.dart';
import 'package:cinelens/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialSearchState());

  void getDataByquery(String query, bool isTV) async {
    LoadingDataState();
    if (isTV) {
      var result = await getIt<GettvshowsByqueryUseCase>().call(params: query);
      result.fold(
        (l) {
          emit(FailedSearchState(message: l));
        },
        (r) {
          emit(LoadedTvShowsState(tvShows: r));
        },
      );
    } else {
      var result = await getIt<GetmovieByqueryUseCase>().call(params: query);
      result.fold(
        (l) {
          emit(FailedSearchState(message: l));
        },
        (r) {
          emit(LoadedMovieState(movies: r));
        },
      );
    }
  }
}
