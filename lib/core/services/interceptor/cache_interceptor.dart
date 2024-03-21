import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gestao_viajem/core/services/interceptor/dio_connectivity_request_retrier.dart';
import '../app_preferences.dart';

class CacheInterceptor implements InterceptorsWrapper {
  final AppPreferences appPreferences;
  final DioConnectivityRequestRetrier requestRetrier;

  CacheInterceptor(this.appPreferences, this.requestRetrier);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method != "GET") {}

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method == "GET") {
      appPreferences.post(
        response.requestOptions.path,
        jsonEncode(response.data),
      );
    }

    handler.resolve(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError) {
      if (err.requestOptions.method == 'GET') {
        return await onResolveCache(err, handler);
      }

      await onResolveScheduleRequestRetry(err, handler);
    }
  }

  Future<void> onResolveCache(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final path = err.requestOptions.path;
    if (appPreferences.preferences.containsKey(path)) {
      final json = await appPreferences.get(path);

      if (json == null) return;

      final data = jsonDecode(json);
      handler.resolve(Response(requestOptions: err.requestOptions, data: data));
    }
  }

  Future<void> onResolveScheduleRequestRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response =
        await requestRetrier.scheduleRequestRetry(err.requestOptions);
    handler.resolve(response);
  }
}
