import 'package:gestao_viajem/feature/expense/controller/expense_controller.dart';
import 'package:gestao_viajem/feature/expense/repository/expense_repository.dart';

import 'package:get_it/get_it.dart';

mixin ExpenseInjection {
  static Future<void> inject(GetIt getIt) async {
    getIt.registerLazySingleton<ExpenseRepository>(
        () => ExpenseRepository(client: getIt()));

    getIt.registerLazySingleton<ExpenseController>(
        () => ExpenseController(getIt()));
  }
}
