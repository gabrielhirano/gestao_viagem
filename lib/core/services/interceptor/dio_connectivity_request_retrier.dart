import 'dart:async';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;
  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();

          final response = await dio.request(
              requestOptions.baseUrl + requestOptions.path,
              options: Options(method: requestOptions.method));

          responseCompleter.complete(response);
        }
      },
    );

    return responseCompleter.future;
  }
}
