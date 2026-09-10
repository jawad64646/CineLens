import 'package:cinelens/common/bloc/generic_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T> extends Cubit<BaseState<T>> {
  BaseCubit() : super(LoadingState<T>());

  Future<void> execute(Future<Either<String, T>> Function() request) async {
    final result = await request();

    result.fold(
      (error) {
        emit(FailureState<T>(error: error));
      },
      (data) {
        emit(LoadedState<T>(data: data));
      },
    );
  }
}
