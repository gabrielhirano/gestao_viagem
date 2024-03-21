import 'package:gestao_viajem/core/config/dependency_injection.dart';
import 'package:gestao_viajem/core/controller/connectivity_controller.dart';
import 'package:gestao_viajem/core/util/app_navigator.dart';

final appConnectivity = getIt<ConnectivityController>();
final appNavigator = getIt<AppNavigator>();
