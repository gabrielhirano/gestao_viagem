import 'package:dio/dio.dart';
import 'package:gestao_viajem_onfly/core/service/error/app_exception.dart';
import 'package:gestao_viajem_onfly/core/service/error/app_failure.dart';

import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';

class ExpenseRepository {
  final Dio client;
  ExpenseRepository({required this.client});

  Future<List<ExpenseModel>> getExpenses() async {
    try {
      final response = await client.get("/expense");

      final dataList = response.data;

      return (dataList as List)
          .map((data) => ExpenseModel.fromMap(data))
          .toList();
    } on CacheException {
      throw CacheFailure('Falha ao buscar dados salvos');
    } catch (err) {
      if (err is ServerException) throw ServerFailure.fromServerException(err);
      throw Failure('Erro Desconhecido!');
    }
  }

  Future<String> registerExpense(ExpenseModel expense) async {
    try {
      await client.post(
        "/expense",
        data: expense.toJson(),
      );

      return 'Nova despesa registrada.';
    } on CacheException {
      throw CacheFailure('Falha ao registrar nova despesa localmente.');
    } catch (err) {
      if (err is ServerException) throw ServerFailure.fromServerException(err);
      throw Failure('Erro Desconhecido!');
    }
  }

  Future<String> updateExpense(ExpenseModel expense) async {
    try {
      await client.put(
        "/expense/${expense.id}",
        data: expense.toJson(),
      );
      return 'Informações sobre a despesa foram alteradas';
    } on CacheException {
      throw CacheFailure('Falha ao modificar despesa localmente.');
    } catch (err) {
      if (err is ServerException) throw ServerFailure.fromServerException(err);
      throw Failure('Erro Desconhecido!');
    }
  }
}
