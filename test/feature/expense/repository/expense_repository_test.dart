import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem_onfly/feature/expense/repository/expense_repository.dart';

import '../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ExpenseRepository expenseRepository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    expenseRepository = ExpenseRepository(client: mockDio);
  });

  group('ExpenseRepository Tests', () {
    test('getExpenses returns a List<ExpenseModel>', () async {
      final expense = jsonDecode(fixture('expense.json'));
      final expense2 = ExpenseModel(
        id: "1",
        name: "Almoço",
        category: ExpenseCategory.feeding,
        value: 30.50,
        date: DateTime.fromMillisecondsSinceEpoch(1674950400000),
        comment: "Restaurante X",
      );

      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/expense'),
          data: [
            expense,
            expense2.toMap(),
          ],
          statusCode: 200));

      final expenses = await expenseRepository.getExpenses();

      expect(expenses, isA<List<ExpenseModel>>());
      expect(expenses.length, 2);
    });

    test('registerExpense returns success message', () async {
      final expense = ExpenseModel.fromMap(jsonDecode(fixture('expense.json')));
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response(
              requestOptions: RequestOptions(path: '/expense'),
              data: 'Nova despesa registrada.',
              statusCode: 201));

      final message = await expenseRepository.registerExpense(expense);

      expect(message, equals('Nova despesa registrada.'));
    });

    test('updateExpense returns update message', () async {
      final expense = ExpenseModel.fromMap(jsonDecode(fixture('expense.json')));
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response(
              requestOptions: RequestOptions(path: '/expense/4'),
              data: 'Informações sobre a despesa foram alteradas',
              statusCode: 200));

      final message = await expenseRepository.updateExpense(expense);

      expect(message, equals('Informações sobre a despesa foram alteradas'));
    });
  });
}
