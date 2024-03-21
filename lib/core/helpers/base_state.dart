import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'app_state.dart';

part 'base_state.g.dart';

class BaseState<T> = BaseStateBase<T> with _$BaseState<T>;

abstract class BaseStateBase<T> with Store {
  @observable
  AppState _state = AppState.none;

  @observable
  T? _data;

  @observable
  DioException? _error;

  @computed
  AppState get getState => _state;

  @computed
  T? get getData => _data;

  @computed
  DioException? get getError => _error;

  @action
  Future<void> execute(Future<T> Function() value) async {
    _state = AppState.loading;
    await value().then((response) {
      if (response.runtimeType == List && (response as List).isEmpty) {
        _state = AppState.empty;
      } else {
        _state = AppState.success;
        _data = response;
      }
    }).catchError((error) {
      _state = AppState.error;
      _error = error;
    });
  }
}
