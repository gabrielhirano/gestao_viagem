// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseState<T> on BaseStateBase<T>, Store {
  Computed<AppState>? _$getStateComputed;

  @override
  AppState get getState =>
      (_$getStateComputed ??= Computed<AppState>(() => super.getState,
              name: 'BaseStateBase.getState'))
          .value;
  Computed<T?>? _$getDataComputed;

  @override
  T? get getData => (_$getDataComputed ??=
          Computed<T?>(() => super.getData, name: 'BaseStateBase.getData'))
      .value;
  Computed<Failure>? _$getErrorComputed;

  @override
  Failure get getError =>
      (_$getErrorComputed ??= Computed<Failure>(() => super.getError,
              name: 'BaseStateBase.getError'))
          .value;

  late final _$_stateAtom =
      Atom(name: 'BaseStateBase._state', context: context);

  @override
  AppState get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(AppState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$_dataAtom = Atom(name: 'BaseStateBase._data', context: context);

  @override
  T? get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(T? value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  late final _$_errorAtom =
      Atom(name: 'BaseStateBase._error', context: context);

  @override
  Failure get _error {
    _$_errorAtom.reportRead();
    return super._error;
  }

  @override
  set _error(Failure value) {
    _$_errorAtom.reportWrite(value, super._error, () {
      super._error = value;
    });
  }

  late final _$executeAsyncAction =
      AsyncAction('BaseStateBase.execute', context: context);

  @override
  Future<void> execute(Future<T> Function() value) {
    return _$executeAsyncAction.run(() => super.execute(value));
  }

  @override
  String toString() {
    return '''
getState: ${getState},
getData: ${getData},
getError: ${getError}
    ''';
  }
}
