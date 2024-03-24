import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gestao_viajem_onfly/core/helpers/extension/string_extension.dart';
import 'package:gestao_viajem_onfly/core/services/app_preferences.dart';
import 'package:gestao_viajem_onfly/core/services/custom_request_options.dart';
import 'package:gestao_viajem_onfly/core/services/error/app_exception.dart';
import 'package:gestao_viajem_onfly/core/services/work_manager_dispacher.dart';

class CacheResolver {
  final AppPreferences appPreferences;

  CacheResolver(this.appPreferences);

  Future<void> saveResponseOnCache(Response response) async {
    appPreferences.post(
      response.requestOptions.path,
      jsonEncode(response.data),
    );
  }

  Future<Response> onResolveGet(RequestOptions requestOptions) async {
    final path = requestOptions.path;

    if (appPreferences.preferences.containsKey(path)) {
      final json = await appPreferences.get(path);

      if (json != null) {
        return Response(
          requestOptions: requestOptions,
          data: jsonDecode(json),
        );
      }
    }

    throw CacheException;
  }

  Future<Response> onResolveChanges(RequestOptions requestOptions) async {
    try {
      final baseEndPoint =
          (requestOptions.baseUrl + requestOptions.path).extractBaseEndPoint;

      if (baseEndPoint == null) throw CacheException;

      final responseGet = await onResolveGet(
        RequestOptions(path: baseEndPoint),
      );

      final data = responseGet.data as List;
      final requestObject = jsonDecode(requestOptions.data);

      switch (requestOptions.method) {
        case 'POST':
          data.add(requestObject);
          break;
        case 'PUT':
        case 'PATCH':
          for (Map<String, dynamic> object in data) {
            if (requestObject['id'] == object['id']) {
              object.clear();
              object.addAll(requestObject);
            }
          }
          break;
        case 'DELETE':
          data.removeWhere((object) => object['id'] == requestObject['id']);
          break;
      }
      final response = Response(
        requestOptions: RequestOptions(path: baseEndPoint),
        data: data,
      );

      saveResponseOnCache(response);
      // saveRequestOnCache(requestOptions);

      return response;
    } catch (e) {
      throw CacheException;
    }
  }

  Future<Response> saveRequestOnCache(RequestOptions requestOptions) async {
    try {
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

      return Response(requestOptions: requestOptions);
    } catch (e) {
      throw CacheException;
    }
  }
}
