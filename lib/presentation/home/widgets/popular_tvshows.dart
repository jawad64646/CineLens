import 'package:cinelens/common/bloc/generic_state.dart';
import 'package:cinelens/common/widgets/tvshow_card.dart';
import 'package:cinelens/domain/entities/tv_show_entity.dart';

import 'package:cinelens/presentation/home/bloc/popular_tvshow_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Populartvshows extends StatelessWidget {
  const Populartvshows({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularTvshowCubit()..getTrendingTvShows(),
      child: BlocBuilder<PopularTvshowCubit, BaseState<List<TvShowEntity>>>(
        builder: (context, state) {
          if (state is LoadingState<List<TvShowEntity>>) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoadedState<List<TvShowEntity>>) {
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
                  final show = data[index];

                  return TvShowCard(show: show);
                },
              ),
            );
          }

          if (state is FailureState<List<TvShowEntity>>) {
            return Center(
              child: Text(
                'Error in fetching data: ${state.error}',
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
