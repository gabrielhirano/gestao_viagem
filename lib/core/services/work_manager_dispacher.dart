import 'package:dio/dio.dart';
import 'package:gestao_viajem_onfly/core/helpers/enum/http_methods_enum.dart';
import 'package:gestao_viajem_onfly/core/services/app_preferences.dart';
import 'package:gestao_viajem_onfly/core/services/custom_request_options.dart';
import 'package:gestao_viajem_onfly/core/services/interceptor/dio_connectivity_request_retrier.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workmanager/workmanager.dart';
import 'dart:developer' as dev;

class WorkManagerDispacherServicer {
  static late final AppPreferences _preferences;
  static late final DioConnectivityRequestRetrier _requestRetrier;

  static initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _preferences = AppPreferences(sharedPreferences);
    _requestRetrier = DioConnectivityRequestRetrier(dio: Dio());
  }

  static Future<bool> dispatcher(
    String taskName,
    Map<String, dynamic>? inputData,
  ) async {
    // dev.log(
    //     'tempo de retry : ${DateTime.now().minute}: ${DateTime.now().second}');
    // dev.log(inputData?['data'] ?? 'sem input');
    dev.log('call dispatcher', name: 'dispatcher');
    // Workmanager().cancelAll();
    if (taskName == 'hasPendingRequest') {
      dev.log('hasPendingRequest', name: 'dispatcher');
      await _resolveRequests();
      // Workmanager().cancelByUniqueName('hasPendingRequest');
      return Future.value(true);
    }
    return Future.value(false);
  }

  static Future registerPendingRequest() async {
    final uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    await Workmanager().registerPeriodicTask(uniqueName, 'hasPendingRequest',
        constraints: Constraints(networkType: NetworkType.connected),
        inputData: {
          'uniqueName': uniqueName,
        });
  }

  static Future<void> _resolveRequests() async {
    await initialize();

    final posts = await _preferences.getList(HttpMethods.post.name);
    final put = await _preferences.getList(HttpMethods.put.name);
    final patch = await _preferences.getList(HttpMethods.patch.name);
    final delete = await _preferences.getList(HttpMethods.delete.name);

    if (posts.isNotEmpty) {
      final postsRequests = posts.map(CustomRequestOptions.fromJson).toList();
      await _resolveRequestRetry(
        HttpMethods.post,
        Future.wait(postsRequests.map(_requestRetrier.requestRetry).toList()),
        _preferences,
      );
    }
    // no caso de put e patch tem que ser sequencial não pode usar o Future.wait
    if (put.isNotEmpty) {
      final putRequests = put.map(CustomRequestOptions.fromJson).toList();
      await _resolveRequestRetry(
        HttpMethods.put,
        Future.wait(putRequests.map(_requestRetrier.requestRetry).toList()),
        _preferences,
      );
    }

    if (patch.isNotEmpty) {
      final patchRequests = patch.map(CustomRequestOptions.fromJson).toList();
      await _resolveRequestRetry(
        HttpMethods.patch,
        Future.wait(patchRequests.map(_requestRetrier.requestRetry).toList()),
        _preferences,
      );
    }

    if (delete.isNotEmpty) {
      final deleteRequests = delete.map(CustomRequestOptions.fromJson).toList();
      await _resolveRequestRetry(
        HttpMethods.delete,
        Future.wait(deleteRequests.map(_requestRetrier.requestRetry).toList()),
        _preferences,
      );
    }
  }

  static Future _resolveRequestRetry(
      HttpMethods method, Future procedure, AppPreferences preferences) {
    return procedure.whenComplete(() => preferences.setList(method.name, []));
  }
}
