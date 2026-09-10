import 'package:cinelens/common/widgets/tvshow_card.dart';
import 'package:cinelens/presentation/search/bloc/search_cubit.dart';
import 'package:cinelens/presentation/search/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVShowsGrid extends StatelessWidget {
  const TVShowsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is InitialSearchState) {
          return const Center(child: Text("No Search yet"));
        }

        if (state is LoadingDataState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is LoadedTvShowsState) {
          return ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(
              overscroll: false,
            ), // Disables overscroll glow
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.65,
              ),
              itemCount: state.tvShows.length,
              itemBuilder: (BuildContext context, int index) {
                return TvShowCard(show: state.tvShows[index]);
              },
            ),
          );
        }
        if (state is FailedSearchState) {
          return Center(
            child: Text(
              'Error in fetching data: ${state.message}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
