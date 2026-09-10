import 'package:cinelens/core/configs/constant/app_urls.dart';
import 'package:cinelens/core/mixins/error_messange_mixin.dart';
import 'package:cinelens/core/network/dio_client.dart';
import 'package:cinelens/data/models/user_req.dart';
import 'package:cinelens/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthApiService {
  Future<Either> SignIn(UserReq user);
  Future<Either> SignUp(UserReq user);
}

class AuthApiServiceImpl extends AuthApiService with GetErrorMessage {
  @override
  Future<Either> SignIn(UserReq user) async {
    try {
      final response = await getIt<DioClient>().post(
        AppUrls.signin,
        data: user.toMap(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> SignUp(UserReq user) async {
    try {
      final response = await getIt<DioClient>().post(
        AppUrls.signup,
        data: user.toMap(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(getErrorMessage(e));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
