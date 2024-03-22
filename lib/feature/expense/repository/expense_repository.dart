import 'package:dio/dio.dart';

import 'package:gestao_viajem/feature/expense/model/expense_model.dart';

class ExpenseRepository {
  final Dio client;
  ExpenseRepository({required this.client});

  Future<List<ExpenseModel>> getExpenses() async {
    try {
      final response = await client.get("/expense");

      final dataList = response.data;

      return (dataList as List<dynamic>)
          .map((e) => ExpenseModel.fromMap(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerExpense(ExpenseModel expense) async {
    try {
      final response = await client.post("/expense", data: expense.toJson());

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
