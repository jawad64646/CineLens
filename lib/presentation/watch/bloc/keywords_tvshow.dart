import 'package:cinelens/common/bloc/generic_cubit.dart';
import 'package:cinelens/domain/entities/keyword_tvshow.dart';
import 'package:cinelens/domain/usecases/keyword_tvshow.dart';
import 'package:cinelens/service_locator.dart';

class KeywordsTvshowCubit extends BaseCubit<List<KeywordTvshowEntity>> {
  KeywordsTvshowCubit();

  Future<void> getKeywordsTvShow(String? iD) async {
    await execute(() => getIt<KeywordTvshowUseCase>().call(params: iD));
  }
}
