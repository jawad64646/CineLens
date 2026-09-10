import 'package:cinelens/core/usecase/usecase.dart';

import 'package:cinelens/domain/repository/auth_repository.dart';
import 'package:cinelens/service_locator.dart';

class IsLoginUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    // TODO: implement call
    return await getIt<AuthRepository>().IsLogin();
  }
}
