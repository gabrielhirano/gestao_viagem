import 'package:gestao_viajem_onfly/core/service/error/app_exception.dart';

class Failure {
  final String message;

  Failure(this.message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);

  factory ServerFailure.fromServerException(ServerException exception) {
    final errorStatus = {
      400: 'Falha na requisição.',
      401: 'Não autorizado.',
      403: 'Não permitido.',
      404: 'Não encontrado',
      500: 'Erro de servidor',
    };

    final message = exception.message ?? errorStatus[exception.statusCode];

    return ServerFailure(message ?? 'Erro desconhecido');
  }
}
