import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gestao_viajem_onfly/core/services/custom_request_options.dart';
import 'package:gestao_viajem_onfly/core/services/work_manager_dispacher.dart';
import 'package:workmanager/workmanager.dart';

import '../app_preferences.dart';

class CacheInterceptor implements InterceptorsWrapper {
  final AppPreferences appPreferences;

  CacheInterceptor(this.appPreferences);

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

      onSaveRequestOnCache(err.requestOptions);
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

  Future<void> onSaveRequestOnCache(RequestOptions requestOptions) async {
    final String key = requestOptions.method;

    final customRequestOptions = CustomRequestOptions(
      baseUrl: requestOptions.baseUrl,
      method: requestOptions.method,
      path: requestOptions.path,
      data: requestOptions.data,
    );

    var listRequest = await appPreferences.getList(key);
    listRequest.add(customRequestOptions.toJson());

    await appPreferences.setList(key, listRequest);

    await WorkManagerDispacherServicer.registerPendingRequest();
  }
}
