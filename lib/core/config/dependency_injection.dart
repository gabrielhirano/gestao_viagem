import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:gestao_viajem/core/services/app_preferences.dart';
import 'package:gestao_viajem/core/services/interceptor/cache_interceptor.dart';
import 'package:gestao_viajem/core/services/custom_dio.dart';
import 'package:gestao_viajem/core/services/interceptor/dio_connectivity_request_retrier.dart';
import 'package:gestao_viajem/core/theme/app_colors.dart';
import 'package:gestao_viajem/feature/home/shared/home_injection.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
mixin DependencyInjection {
  static Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences),
    );

    getIt.registerLazySingleton<DioConnectivityRequestRetrier>(
      () => DioConnectivityRequestRetrier(
        dio: Dio(),
        connectivity: Connectivity(),
      ),
    );
    getIt.registerLazySingleton<Dio>(
      () => CustomDio(CacheInterceptor(getIt(), getIt())),
    );

    getIt.registerLazySingleton<IAppColors>(
      () => AppColors(),
    );

    //! Features
    Future.wait([
      HomeInjection.inject(getIt),
    ]);
  }
}
