import 'package:connectivity/connectivity.dart';

import 'package:gestao_viajem_onfly/core/service/app_preferences.dart';

import 'package:gestao_viajem_onfly/core/service/interceptor/dio_connectivity_request_retrier.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_controller.g.dart';

enum ConnectivityEnum { online, offline }

class ConnectivityController = ConnectivityControllerBase
    with _$ConnectivityController;

abstract class ConnectivityControllerBase with Store {
  late final Connectivity _connectivity;
  final AppPreferences preferences;
  final DioConnectivityRequestRetrier requestRetrier;

  ConnectivityControllerBase(
    Connectivity connectivityInjection,
    this.preferences,
    this.requestRetrier,
  ) {
    _connectivity = connectivityInjection;
    _connectivity.onConnectivityChanged.listen(setConnectivity);
    checkConnectivity();
  }

  @observable
  ConnectivityEnum connectivity = ConnectivityEnum.online;

  @action
  void setConnectivity(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      connectivity = ConnectivityEnum.offline;
    } else {
      connectivity = ConnectivityEnum.online;
    }
  }

  void checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    setConnectivity(result);
  }

  @computed
  bool get isOffline => connectivity == ConnectivityEnum.offline;
}
