import 'package:dio/dio.dart';

class ServerException extends DioException {
  final int statusCode;
  final String? statusMessage;
  ServerException(this.statusCode, {this.statusMessage})
      : super(requestOptions: RequestOptions());
}

class CacheException extends DioException {
  CacheException() : super(requestOptions: RequestOptions());
}
