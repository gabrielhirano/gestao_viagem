import 'dart:async';

import 'package:dio/dio.dart';

import 'package:gestao_viajem_onfly/core/services/custom_request_options.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;

  DioConnectivityRequestRetrier({required this.dio});

  Future<Response> requestRetry(CustomRequestOptions requestOptions) async {
    var response = await dio.request(
        requestOptions.baseUrl + requestOptions.path,
        data: requestOptions.data,
        options: Options(method: requestOptions.method));
    return response;
  }
}
