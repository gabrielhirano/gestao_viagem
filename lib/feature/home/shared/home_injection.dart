
import 'package:get_it/get_it.dart';

mixin HomeInjection {
  static Future<void> inject(GetIt getIt) async {
    // getIt.registerLazySingleton<ExpenseRepository>(
    //     () => ExpenseRepository(client: getIt()));

    // getIt.registerLazySingleton<HomeController>(() => HomeController(getIt()));
  }
}
