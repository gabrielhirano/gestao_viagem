import 'package:gestao_viajem/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem/feature/expense/repository/expense_repository.dart';

import 'package:mobx/mobx.dart';

import 'package:gestao_viajem/core/helpers/base_state.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final state = BaseState<List<ExpenseModel>>();

  final ExpenseRepository repository;

  HomeControllerBase(this.repository);

  Future<void> getExpenses() async {
    await state.execute(() => repository.getExpenses());
  }

  double get totalSpend =>
      state.getData?.fold<double>(
          0, (previousValue, expense) => previousValue += expense.value) ??
      0;
  // Future<void> postPost() async {
  //   // await state.execute(() => repository.postPost());
  //   await repository.postPost();
  // }
}
