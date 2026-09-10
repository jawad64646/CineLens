import 'package:cinelens/common/bloc/generic_cubit.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';
import 'package:cinelens/domain/usecases/now_playing.dart';
import 'package:cinelens/service_locator.dart';

class NowPlayingCubit extends BaseCubit<List<MovieEntity>> {
  NowPlayingCubit();

  Future<void> getNowPlaying() async {
    await execute(() => getIt<NowPlayingUseCase>().call());
  }
}
