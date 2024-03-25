import 'package:dio/dio.dart';
import 'package:gestao_viajem_onfly/core/service/cache_resolver.dart';

class CacheInterceptor implements InterceptorsWrapper {
  final CacheResolver cacheResolver;
  CacheInterceptor(this.cacheResolver);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method != "GET") {}

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method == "GET") {
      cacheResolver.saveResponseOnCache(response);
    }

    handler.resolve(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError) {
      if (err.requestOptions.method == 'GET') {
        await cacheResolver
            .onResolveGet(err.requestOptions)
            .then((response) => handler.resolve(response))
            .onError<DioException>((exception, _) {
          handler.reject(exception);
        });
        return;
      }
      await cacheResolver
          .onResolveChanges(err.requestOptions)
          .then((response) => handler.resolve(response))
          .onError<DioException>((exception, _) => handler.reject(exception));
    }
  }
}
