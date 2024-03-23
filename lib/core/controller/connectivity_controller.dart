import 'package:connectivity/connectivity.dart';
import 'package:gestao_viajem_onfly/core/helpers/enum/http_methods_enum.dart';
import 'package:gestao_viajem_onfly/core/services/app_preferences.dart';
import 'package:gestao_viajem_onfly/core/services/custom_request_options.dart';
import 'package:gestao_viajem_onfly/core/services/interceptor/dio_connectivity_request_retrier.dart';
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
      // checkRequestRetry();
    }
  }

  void checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    setConnectivity(result);
  }

  Future<void> checkRequestRetry() async {
    final posts = await preferences.getList(HttpMethods.post.name);
    final put = await preferences.getList(HttpMethods.put.name);
    final patch = await preferences.getList(HttpMethods.patch.name);
    final delete = await preferences.getList(HttpMethods.delete.name);

    if (posts.isNotEmpty) {
      final postsRequests = posts.map(CustomRequestOptions.fromJson).toList();
      await resolveRequestRetry(
        HttpMethods.post,
        Future.wait(postsRequests.map(requestRetrier.requestRetry).toList()),
      );
    }
    // no caso de put e patch tem que ser sequencial não pode usar o Future.wait
    if (put.isNotEmpty) {
      final putRequests = put.map(CustomRequestOptions.fromJson).toList();
      await resolveRequestRetry(
        HttpMethods.put,
        Future.wait(putRequests.map(requestRetrier.requestRetry).toList()),
      );
    }

    if (patch.isNotEmpty) {
      final patchRequests = patch.map(CustomRequestOptions.fromJson).toList();
      await resolveRequestRetry(
        HttpMethods.patch,
        Future.wait(patchRequests.map(requestRetrier.requestRetry).toList()),
      );
    }

    if (delete.isNotEmpty) {
      final deleteRequests = delete.map(CustomRequestOptions.fromJson).toList();
      await resolveRequestRetry(
        HttpMethods.delete,
        Future.wait(deleteRequests.map(requestRetrier.requestRetry).toList()),
      );
    }
  }

  Future resolveRequestRetry(HttpMethods method, Future procedure) {
    return procedure.whenComplete(() => preferences.setList(method.name, []));
  }

  @computed
  bool get isOffline => connectivity == ConnectivityEnum.offline;
}
