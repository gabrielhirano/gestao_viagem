import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:gestao_viajem_onfly/core/controller/connectivity_controller.dart';

import 'package:gestao_viajem_onfly/core/service/app_preferences.dart';
import 'package:gestao_viajem_onfly/core/service/cache_resolver.dart';
import 'package:gestao_viajem_onfly/core/service/interceptor/cache_interceptor.dart';
import 'package:gestao_viajem_onfly/core/service/custom_dio.dart';
import 'package:gestao_viajem_onfly/core/service/interceptor/dio_connectivity_request_retrier.dart';

import 'package:gestao_viajem_onfly/core/theme/app_colors.dart';
import 'package:gestao_viajem_onfly/core/util/app_navigator.dart';
import 'package:gestao_viajem_onfly/core/util/getit_global.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/shared/boarding_pass_injection.dart';
import 'package:gestao_viajem_onfly/feature/expense/shared/expense_injection.dart';

import 'package:shared_preferences/shared_preferences.dart';

mixin DependencyInjection {
  static Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences),
    );

    getIt.registerLazySingleton<DioConnectivityRequestRetrier>(
      () => DioConnectivityRequestRetrier(
        dio: Dio(),
      ),
    );

    getIt.registerLazySingleton<CacheResolver>(
      () => CacheResolver(getIt()),
    );

    getIt.registerLazySingleton<Dio>(
      () => CustomDio(CacheInterceptor(getIt())),
    );

    getIt.registerLazySingleton<Connectivity>(
      () => Connectivity(),
    );

    getIt.registerLazySingleton<ConnectivityController>(
      () => ConnectivityController(getIt()),
    );

    getIt.registerLazySingleton<AppNavigator>(
      () => AppNavigator(),
    );

    getIt.registerLazySingleton<IAppColors>(
      () => AppColors(),
    );

    //! Features
    Future.wait([
      ExpenseInjection.inject(getIt),
      BoardingPassInjection.inject(getIt),
    ]);
  }
}
