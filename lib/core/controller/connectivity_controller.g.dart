// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectivityController on ConnectivityControllerBase, Store {
  Computed<bool>? _$isOfflineComputed;

  @override
  bool get isOffline =>
      (_$isOfflineComputed ??= Computed<bool>(() => super.isOffline,
              name: 'ConnectivityControllerBase.isOffline'))
          .value;

  late final _$connectivityAtom =
      Atom(name: 'ConnectivityControllerBase.connectivity', context: context);

  @override
  ConnectivityEnum get connectivity {
    _$connectivityAtom.reportRead();
    return super.connectivity;
  }

  @override
  set connectivity(ConnectivityEnum value) {
    _$connectivityAtom.reportWrite(value, super.connectivity, () {
      super.connectivity = value;
    });
  }

  late final _$ConnectivityControllerBaseActionController =
      ActionController(name: 'ConnectivityControllerBase', context: context);

  @override
  void setConnectivity(ConnectivityResult connectivityResult) {
    final _$actionInfo = _$ConnectivityControllerBaseActionController
        .startAction(name: 'ConnectivityControllerBase.setConnectivity');
    try {
      return super.setConnectivity(connectivityResult);
    } finally {
      _$ConnectivityControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
connectivity: ${connectivity},
isOffline: ${isOffline}
    ''';
  }
}
