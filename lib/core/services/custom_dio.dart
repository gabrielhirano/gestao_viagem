import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class CustomDio extends DioForNative {
  final Interceptor interceptor;
  CustomDio(this.interceptor) {
    options.baseUrl = "https://65f8c8d0df15145246100680.mockapi.io/api"; // API

    interceptors.add(interceptor);
  }
}
