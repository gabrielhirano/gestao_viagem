import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem_onfly/feature/expense/repository/expense_repository.dart';

import 'package:mobx/mobx.dart';

import 'package:gestao_viajem_onfly/core/util/base_state.dart';

class ExpenseController {
  ExpenseController(this.repository);
  final ExpenseRepository repository;

  final state = BaseState<List<ExpenseModel>>();
  final changedState = BaseState();

  Future<void> getExpenses() async {
    await state.execute(() => repository.getExpenses());
  }

  Future<void> createExpense(ExpenseModel expense) async {
    await changedState.execute(() => repository.registerExpense(expense));
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await changedState.execute(() => repository.updateExpense(expense));
  }

  @computed
  double get totalSpend =>
      state.getData?.fold<double>(
          0, (previousValue, expense) => previousValue += expense.value) ??
      0;
}
