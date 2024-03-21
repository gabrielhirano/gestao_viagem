import 'package:connectivity/connectivity.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_controller.g.dart';

enum ConnectivityEnum { online, offline }

class ConnectivityController = ConnectivityControllerBase
    with _$ConnectivityController;

abstract class ConnectivityControllerBase with Store {
  late final Connectivity _connectivity;

  ConnectivityControllerBase(Connectivity connectivityInjection) {
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
