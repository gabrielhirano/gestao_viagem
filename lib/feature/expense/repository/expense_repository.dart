import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:gestao_viajem/feature/expense/model/expense_model.dart';

class ExpenseRepository {
  final Dio client;
  ExpenseRepository({
    required this.client,
  });

  Future<List<ExpenseModel>> getExpenses() async {
    try {
      // final response = await client.get("/posts");
      final string = await rootBundle.loadString('assets/expenses_mock.json');

      final response = jsonDecode(string);

      return (response as List<dynamic>)
          .map((e) => ExpenseModel.fromMap(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Future<dynamic> postPost() async {
  //   try {
  //     final response = await client.post(
  //       "/posts",
  //       data: jsonEncode({
  //         'title': 'foo',
  //         'body': 'bar',
  //         'userId': 1,
  //       }),
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
