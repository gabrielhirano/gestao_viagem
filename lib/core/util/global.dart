import 'package:gestao_viajem_onfly/core/config/dependency_injection.dart';
import 'package:gestao_viajem_onfly/core/controller/connectivity_controller.dart';
import 'package:gestao_viajem_onfly/core/util/app_navigator.dart';

final appConnectivity = getIt<ConnectivityController>();
final appNavigator = getIt<AppNavigator>();
