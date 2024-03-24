import 'package:dio/dio.dart';
import 'package:gestao_viajem_onfly/core/services/error/app_exception.dart';
import 'package:gestao_viajem_onfly/core/services/error/app_failure.dart';

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

  Future registerExpense(ExpenseModel expense) async {
    try {
      await client.post(
        "/expense",
        data: expense.toJson(),
      );
    } on CacheException {
      throw CacheFailure('Falha ao registrar nova despesa localmente.');
    } catch (err) {
      if (err is ServerException) throw ServerFailure.fromServerException(err);
      throw Failure('Erro Desconhecido!');
    }
  }

  Future updateExpense(ExpenseModel expense) async {
    try {
      await client.put(
        "/expense/${expense.id}",
        data: expense.toJson(),
      );
    } on CacheException {
      throw CacheFailure('Falha ao modificar despesa localmente.');
    } catch (err) {
      if (err is ServerException) throw ServerFailure.fromServerException(err);
      throw Failure('Erro Desconhecido!');
    }
  }
}
