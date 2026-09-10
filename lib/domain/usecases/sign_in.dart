import 'package:cinelens/core/usecase/usecase.dart';
import 'package:cinelens/data/models/user_req.dart';

import 'package:cinelens/domain/repository/auth_repository.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase extends UseCase<Either, UserReq> {
  @override
  Future<Either> call({UserReq? params}) async {
    // TODO: implement call
    return await getIt<AuthRepository>().SignIn(params!);
  }
}
