import 'package:cinelens/core/usecase/usecase.dart';
import 'package:cinelens/domain/entities/movie_entity.dart';
import 'package:cinelens/domain/repository/movie_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class NowPlayingUseCase
    extends UseCase<Either<String, List<MovieEntity>>, dynamic> {
  @override
  Future<Either<String, List<MovieEntity>>> call({dynamic params}) async {
    return await getIt<MovieRepository>().getNowPlaying();
  }
}
