abstract class BaseState<T> {}

class LoadingState<T> extends BaseState<T> {}

class LoadedState<T> extends BaseState<T> {
  final T data;

  LoadedState({required this.data});
}

class FailureState<T> extends BaseState<T> {
  final String error;

  FailureState({required this.error});
}
