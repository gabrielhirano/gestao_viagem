import 'package:dio/dio.dart';

import 'package:gestao_viajem_onfly/core/helper/enum/http_methods_enum.dart';
import 'package:gestao_viajem_onfly/core/service/app_preferences.dart';
import 'package:gestao_viajem_onfly/core/model/custom_request_options.dart';
import 'package:gestao_viajem_onfly/core/service/interceptor/dio_connectivity_request_retrier.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:workmanager/workmanager.dart';
import 'dart:developer' as dev;

class WorkManagerDispacherService {
  static late AppPreferences _preferences;
  static late DioConnectivityRequestRetrier _requestRetrier;

  static _initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _preferences = AppPreferences(sharedPreferences);
    _requestRetrier = DioConnectivityRequestRetrier(dio: Dio());
  }

  static Future<bool> dispatcher(
    String taskName,
    Map<String, dynamic>? inputData,
  ) async {
    dev.log('call dispatcher', name: 'dispatcher');

    if (taskName == 'hasPendingRequest') {
      dev.log('hasPendingRequest', name: 'dispatcher');

      await _resolveRequests();

      return Future.value(true);
    }
    return Future.value(false);
  }

  static Future<void> registerPendingRequest() async {
    if (await hasPendingRequest()) return;

    final uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    await Workmanager().registerPeriodicTask(
      uniqueName,
      'hasPendingRequest',
      constraints: Constraints(networkType: NetworkType.connected),
      inputData: {
        'uniqueName': uniqueName,
      },
    );
  }

  static Future<void> _resolveRequests() async {
    await _initialize();

    final posts = await _preferences.getList(HttpMethods.post.name);
    final put = await _preferences.getList(HttpMethods.put.name);
    final patch = await _preferences.getList(HttpMethods.patch.name);
    final delete = await _preferences.getList(HttpMethods.delete.name);

    if (posts.isNotEmpty) {
      final postsRequests = posts.map(CustomRequestOptions.fromJson).toList();
      await _resolveRequestRetry(
        HttpMethods.post,
        Future.wait(postsRequests.map(_requestRetrier.requestRetry).toList()),
      );
    }
    // no caso de put e patch tem que ser sequencial não pode usar o Future.wait
    if (put.isNotEmpty) {
      final putRequests = put.map(CustomRequestOptions.fromJson).toList();

      List<Future<dynamic> Function()> functionList = putRequests
          .map((request) =>
              () async => (await _requestRetrier.requestRetry(request)).data)
          .toList();

      await _resolveRequestRetry(
        HttpMethods.put,
        runQueue(functionList),
      );
    }

    if (patch.isNotEmpty) {
      final patchRequests = patch.map(CustomRequestOptions.fromJson).toList();
      List<Future<dynamic> Function()> functionList = patchRequests
          .map((request) =>
              () async => (await _requestRetrier.requestRetry(request)).data)
          .toList();

      await _resolveRequestRetry(
        HttpMethods.patch,
        runQueue(functionList),
      );
    }

    if (delete.isNotEmpty) {
      final deleteRequests = delete.map(CustomRequestOptions.fromJson).toList();
      await _resolveRequestRetry(
        HttpMethods.delete,
        Future.wait(deleteRequests.map(_requestRetrier.requestRetry).toList()),
      );
    }
  }

  static Future _resolveRequestRetry(HttpMethods method, Future procedure) {
    return procedure.then((_) {
      _preferences.delete(method.name);
    }).onError((error, stackTrace) {
      // se houver algum erro na execução das request
      // ele irá capturar aqui e podemos mandar para uma rotina de tratamento
    });
  }

  static Future<bool> hasPendingRequest() async {
    await _initialize();

    final posts = await _preferences.getList(HttpMethods.post.name);
    final put = await _preferences.getList(HttpMethods.put.name);
    final patch = await _preferences.getList(HttpMethods.patch.name);
    final delete = await _preferences.getList(HttpMethods.delete.name);

    return [
      posts.isNotEmpty,
      put.isNotEmpty,
      patch.isNotEmpty,
      delete.isNotEmpty,
    ].contains(true);
  }
}
