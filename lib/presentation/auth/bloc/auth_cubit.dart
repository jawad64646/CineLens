import 'package:cinelens/data/models/user_req.dart';

import 'package:cinelens/domain/usecases/sign_in.dart';
import 'package:cinelens/domain/usecases/sign_up.dart';
import 'package:cinelens/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn({required UserReq user}) async {
    emit(AuthLoading());
    final result = await GetIt.I<SignInUseCase>().call(params: user);
    result.fold(
      (error) => emit(AuthFailure(message: error.toString())),
      (data) => emit(AuthSuccess()),
    );
  }

  Future<void> signUp({required UserReq user}) async {
    emit(AuthLoading());
    final result = await GetIt.I<SignUpUseCase>().call(params: user);
    result.fold(
      (error) => emit(AuthFailure(message: error.toString())),
      (data) => emit(AuthSuccess()),
    );
  }
}
