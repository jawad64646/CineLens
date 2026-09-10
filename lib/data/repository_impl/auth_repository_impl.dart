import 'package:cinelens/core/storage/secure_storage.dart';
import 'package:cinelens/core/storage/storage_keys.dart';
import 'package:cinelens/data/data_source/auth_api_service.dart';
import 'package:cinelens/data/models/user_req.dart';
import 'package:cinelens/domain/repository/auth_repository.dart';

import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<dynamic, dynamic>> SignIn(UserReq user) async {
    final result = await getIt<AuthApiService>().SignIn(user);
    return result.fold((l) => Left(l), (data) async {
      if (data != null &&
          data is Map &&
          data['user'] != null &&
          data['user']['token'] != null) {
        await SecureStorage().write(
          key: StorageKeys.accessToken,
          value: data['user']['token'].toString(),
        );
      }
      return Right(data);
    });
  }

  @override
  Future<Either<dynamic, dynamic>> SignUp(UserReq user) async {
    final result = await getIt<AuthApiService>().SignUp(user);
    return result.fold((l) => Left(l), (data) async {
      if (data != null &&
          data is Map &&
          data['user'] != null &&
          data['user']['token'] != null) {
        await SecureStorage().write(
          key: StorageKeys.accessToken,
          value: data['user']['token'].toString(),
        );
      }
      return Right(data);
    });
  }

  @override
  Future<bool> IsLogin() async {
    final token = await SecureStorage().read(StorageKeys.accessToken);
    return token != null && token.isNotEmpty;
  }
}
