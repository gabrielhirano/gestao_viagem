import 'package:gestao_viajem_onfly/core/controller/connectivity_controller.dart';
import 'package:gestao_viajem_onfly/core/util/app_navigator.dart';
import 'package:gestao_viajem_onfly/core/util/getit_global.dart';

final appConnectivity = getIt<ConnectivityController>();
final appNavigator = getIt<AppNavigator>();

Future<void> runQueue(List<Future Function()> queue) async {
  for (final function in queue) {
    await function();
  }
}
