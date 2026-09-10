import 'package:flutter_bloc/flutter_bloc.dart';

enum States { tv, movie }

class SwitchingCubit extends Cubit<States> {
  SwitchingCubit() : super(States.movie);

  void updateState({bool? isTV}) async {
    if (isTV != null) {
      if (isTV) {
        emit(States.tv);
      } else {
        emit(States.movie);
      }
    }
  }
}
