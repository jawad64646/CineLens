import 'package:cinelens/common/bloc/generic_state.dart';

import 'package:cinelens/presentation/home/bloc/trending_movie_cubit.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingMovieCubit()..getTrendingMovies(),
      child: BlocBuilder<TrendingMovieCubit, BaseState<List<String>>>(
        builder: (context, state) {
          if (state is LoadingState<List<String>>) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoadedState<List<String>>) {
            return FanCarouselImageSlider.sliderType1(
              imagesLink: state.data,
              isAssets: false,
              autoPlay: true,
              sliderHeight: 400,
              showIndicator: false,
              userCanDrag: true,
            );
          }

          if (state is FailureState<List<String>>) {
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
