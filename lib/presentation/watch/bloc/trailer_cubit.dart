import 'package:cinelens/domain/usecases/get_tv_trailer.dart';
import 'package:cinelens/domain/usecases/trailer_movie.dart';
import 'package:cinelens/presentation/watch/bloc/trailer_state.dart';
import 'package:cinelens/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TrailerCubit extends Cubit<TrailerState> {
  TrailerCubit() : super(LoadingTrailerState());

  YoutubePlayerController? _controller;

  Future<void> loadTrailer(String videoId) async {
    emit(LoadingTrailerState());

    final data = await getIt<GetTrailerUseCase>().call(params: videoId);

    data.fold(
      (error) {
        emit(FailedTrailerState(error: error));
      },
      (trailer) {
        try {
          _controller?.close();

          _controller = YoutubePlayerController(
            params: const YoutubePlayerParams(
              mute: false,
              loop: false,
              showFullscreenButton: true,
              showControls: true,
            ),
          );

          _controller!.loadVideoById(videoId: trailer.key!);

          emit(LoadedTrailerState(controller: _controller!));
        } catch (e) {
          emit(FailedTrailerState(error: e.toString()));
        }
      },
    );
  }

  Future<void> loadTvTrailer(String tvId) async {
    emit(LoadingTrailerState());

    final data = await getIt<GetTvTrailerUseCase>().call(params: tvId);

    data.fold(
      (error) {
        emit(FailedTrailerState(error: error));
      },
      (trailer) {
        try {
          _controller?.close();

          _controller = YoutubePlayerController(
            params: const YoutubePlayerParams(
              mute: false,
              loop: false,
              showFullscreenButton: true,
              showControls: true,
            ),
          );

          _controller!.loadVideoById(videoId: trailer.key!);

          emit(LoadedTrailerState(controller: _controller!));
        } catch (e) {
          emit(FailedTrailerState(error: e.toString()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _controller?.close();
    return super.close();
  }
}
