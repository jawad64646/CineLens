import 'package:cinelens/presentation/watch/bloc/trailer_cubit.dart';
import 'package:cinelens/presentation/watch/bloc/trailer_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayer extends StatefulWidget {
  final String videoID;
  final bool isTv;
  const VideoPlayer({super.key, required this.videoID, this.isTv = false});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = TrailerCubit();
        if (widget.isTv) {
          cubit.loadTvTrailer(widget.videoID);
        } else {
          cubit.loadTrailer(widget.videoID);
        }
        return cubit;
      },
      child: BlocBuilder<TrailerCubit, TrailerState>(
        builder: (BuildContext context, state) {
          if (state is LoadingTrailerState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LoadedTrailerState) {
            var controller = state.controller;
            return YoutubePlayer(controller: controller!, aspectRatio: 16 / 9);
          }
          if (state is FailedTrailerState) {
            return Center(child: Text("error in fetching data ${state.error}"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
