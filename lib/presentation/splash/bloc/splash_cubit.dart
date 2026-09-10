import 'package:cinelens/domain/usecases/is_login.dart';
import 'package:cinelens/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashDisplayed());

  void checkSignIn() async {
    await Future.delayed(Duration(seconds: 2));
    final result = await GetIt.I<IsLoginUseCase>().call();

    if (result) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }
}
