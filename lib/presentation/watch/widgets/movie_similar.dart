import 'package:cinelens/common/bloc/generic_state.dart';
import 'package:cinelens/common/widgets/movie_card.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';

import 'package:cinelens/presentation/watch/bloc/similar_movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarMovies extends StatelessWidget {
  final String? movieID;
  const SimilarMovies({super.key, this.movieID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SimilarMovieCubit()..getSimilarMovies(movieID),
      child: BlocBuilder<SimilarMovieCubit, BaseState<List<MovieEntity>>>(
        builder: (context, state) {
          if (state is LoadingState<List<MovieEntity>>) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoadedState<List<MovieEntity>>) {
            final data = state.data;

            return SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemBuilder: (context, index) {
                  final movie = data[index];

                  return MovieCard(movie: movie);
                },
              ),
            );
          }

          if (state is FailureState<List<MovieEntity>>) {
            return Center(
              child: Text(
                ' Error in fetching data: ${state.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
