import 'package:cinelens/common/widgets/trailer_entity.dart';
import 'package:cinelens/core/usecase/usecase.dart';
import 'package:cinelens/domain/repository/tvshow_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetTvTrailerUseCase
    extends UseCase<Either<String, TrailerEntity>, String?> {
  @override
  Future<Either<String, TrailerEntity>> call({String? params}) async {
    // TODO: implement call
    return await getIt<TvshowRepository>().getTvTrailer(params);
  }
}
