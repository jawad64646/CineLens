import 'package:cinelens/common/widgets/movie_card.dart';
import 'package:cinelens/presentation/search/bloc/search_cubit.dart';
import 'package:cinelens/presentation/search/bloc/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is InitialSearchState) {
          return const Center(child: Text('No search yet'));
        }

        if (state is LoadingDataState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LoadedMovieState) {
          if (state.movies.isEmpty) {
            return const Center(child: Text('No movies found'));
          }

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
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: state.movies[index]);
              },
            ),
          );
        }

        if (state is FailedSearchState) {
          return Center(
            child: Text(
              'Error fetching data: ${state.message}',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
