import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class CustomDio extends DioForNative {
  final Interceptor interceptor;
  CustomDio(this.interceptor) {
    options.baseUrl = "https://jsonplaceholder.typicode.com"; // API

    interceptors.add(interceptor);
  }
}
