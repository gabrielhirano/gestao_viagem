import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  group('ExpenseModel', () {
    test('fromJson() and toJson() should be symmetric', () {
      final expenseJson = jsonEncode(jsonDecode(fixture('expense.json')));

      final expense = ExpenseModel(
        id: "1",
        name: "Almoço",
        category: ExpenseCategory.feeding,
        value: 30.50,
        date: DateTime.fromMillisecondsSinceEpoch(1674950400000),
        comment: "Restaurante X",
      );

      expect(ExpenseModel.fromJson(expenseJson), expense);
      expect(expense.toJson(), expenseJson);
    });

    test('createExpenseFromForm() should create ExpenseModel from form data',
        () {
      final expense = ExpenseModel.createExpenseFromForm(
        name: "Jantar",
        value: "25,00",
        date: "20/07/2024",
        category: ExpenseCategory.feeding,
        comment: "Restaurante Y",
      );

      expect(expense, isNotNull);
      expect(expense!.name, "Jantar");
      expect(expense.value, 25.00);
      expect(expense.date, DateTime(2024, 7, 20));
      expect(expense.category, ExpenseCategory.feeding);
      expect(expense.comment, "Restaurante Y");
    });
  });
}
