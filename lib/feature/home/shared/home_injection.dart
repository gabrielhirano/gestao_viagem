import 'package:gestao_viajem_onfly/feature/expense/repository/expense_repository.dart';

import 'package:gestao_viajem_onfly/feature/home/repository/home_repository.dart';
import 'package:get_it/get_it.dart';

mixin HomeInjection {
  static Future<void> inject(GetIt getIt) async {
    // getIt.registerLazySingleton<ExpenseRepository>(
    //     () => ExpenseRepository(client: getIt()));

    // getIt.registerLazySingleton<HomeController>(() => HomeController(getIt()));
  }
}
