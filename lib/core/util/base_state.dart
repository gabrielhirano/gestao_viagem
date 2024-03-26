import 'package:gestao_viajem_onfly/core/service/error/app_failure.dart';
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
  Failure _error = Failure('Nenhuma falha encontrada!');

  @computed
  AppState get getState => _state;

  @computed
  T? get getData => _data;

  @computed
  Failure get getError => _error;

  @action
  Future<void> execute(Future<T> Function() process) async {
    _state = AppState.loading;
    try {
      T response = await process();
      if (response is List && (response as List).isEmpty) {
        _state = AppState.empty;
      } else {
        _state = AppState.success;
        _data = response;
      }
    } catch (error) {
      if (error is Failure) {
        _error = error;
      }
      _state = AppState.error;
    }
  }
}
