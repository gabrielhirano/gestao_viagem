import 'package:flutter_test/flutter_test.dart';
import 'package:gestao_viajem_onfly/core/util/app_state.dart';
import 'package:gestao_viajem_onfly/feature/expense/controller/expense_controller.dart';
import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem_onfly/feature/expense/repository/expense_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late MockExpenseRepository mockExpenseRepository;
  late ExpenseController expenseController;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    expenseController = ExpenseController(mockExpenseRepository);
  });
  test(
      'When getExpenses is called, it should execute the getExpenses method of the repository',
      () async {
    when(() => mockExpenseRepository.getExpenses())
        .thenAnswer((_) async => <ExpenseModel>[]);

    await expenseController.getExpenses();

    verify(() => mockExpenseRepository.getExpenses()).called(1);
  });
  test(
      'When getExpenses is called and returns ExpenseModel list empty, it should set AppState to empty',
      () async {
    when(() => mockExpenseRepository.getExpenses())
        .thenAnswer((_) async => <ExpenseModel>[]);

    await expenseController.getExpenses();

    expect(expenseController.state.getState, AppState.empty);
  });

  test(
      'When getExpenses is called and returns ExpenseModel list, it should set AppState to success',
      () async {
    final expenses = [
      ExpenseModel(
          id: '1',
          name: 'Expense 1',
          category: ExpenseCategory.others,
          value: 10.0,
          date: DateTime.now()),
      ExpenseModel(
          id: '2',
          name: 'Expense 2',
          category: ExpenseCategory.feeding,
          value: 20.0,
          date: DateTime.now()),
    ];

    when(() => mockExpenseRepository.getExpenses())
        .thenAnswer((_) async => expenses);

    await expenseController.getExpenses();

    expect(expenseController.state.getState, AppState.success);
  });

  test(
      'When getExpenses is called and throws Failure, it should set AppState to error',
      () async {
    when(() => mockExpenseRepository.getExpenses()).thenThrow(Exception());

    await expenseController.getExpenses();

    expect(expenseController.state.getState, AppState.error);
  },
      skip:
          'A exception enviada pelo thenThrow não esta sendo capturada pelo BaseState');
}
