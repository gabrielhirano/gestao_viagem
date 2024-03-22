import 'package:gestao_viajem/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem/feature/expense/repository/expense_repository.dart';

import 'package:mobx/mobx.dart';

import 'package:gestao_viajem/core/util/base_state.dart';

part 'expense_controller.g.dart';

class ExpenseController = ExpenseControllerBase with _$ExpenseController;

abstract class ExpenseControllerBase with Store {
  final state = BaseState<List<ExpenseModel>>();

  final ExpenseRepository repository;

  ExpenseControllerBase(this.repository);

  @action
  Future<void> getExpenses() async {
    await state.execute(() => repository.getExpenses());
  }

  Future registerExpense(ExpenseModel expense) async {
    return repository.registerExpense(expense);
  }

  Future updateExpense(ExpenseModel expense) async {
    return repository.updateExpense(expense);
  }

  @computed
  double get totalSpend =>
      state.getData?.fold<double>(
          0, (previousValue, expense) => previousValue += expense.value) ??
      0;
}
