import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailerState {}

class LoadingTrailerState extends TrailerState {}

class LoadedTrailerState extends TrailerState {
  final YoutubePlayerController? controller;

  LoadedTrailerState({required this.controller});
}

class FailedTrailerState extends TrailerState {
  final String error;

  FailedTrailerState({required this.error});
}

// final controller = YoutubePlayerController(
//   initialVideoId: '<video-id>',
//   flags: const YoutubePlayerFlags(
//     autoPlay: true,
//     mute: false,
//   ),
// );
// YoutubePlayer(
//   controller: controller,
//   showVideoProgressIndicator: true,
//   progressIndicatorColor: Colors.red,
// )
// @override
// void dispose() {
//   controller.dispose();
//   super.dispose();
// }
