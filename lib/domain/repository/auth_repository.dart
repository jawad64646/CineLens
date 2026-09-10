import 'package:cinelens/data/models/user_req.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> SignIn(UserReq user);
  Future<Either> SignUp(UserReq user);
  Future<bool> IsLogin();
}
