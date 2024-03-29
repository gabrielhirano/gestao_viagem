import 'package:gestao_viajem_onfly/feature/boarding_pass/controller/boarding_pass_controller.dart';
import 'package:get_it/get_it.dart';

mixin BoardingPassInjection {
  static Future<void> inject(GetIt getIt) async {
    getIt.registerLazySingleton<BoardingPassController>(
        () => BoardingPassController());
  }
}
