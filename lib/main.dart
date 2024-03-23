import 'package:flutter/material.dart';
import 'package:gestao_viajem_onfly/core/config/dependency_injection.dart';
import 'package:gestao_viajem_onfly/core/config/onfly_app.dart';
import 'package:gestao_viajem_onfly/core/config/teste.dart';
import 'package:gestao_viajem_onfly/core/services/work_manager_dispacher.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() =>
    Workmanager().executeTask(WorkManagerDispacherServicer.dispatcher);

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DependencyInjection.init();
//   runApp(const OnflyApp());

//   // await initializeService();
//   // runApp(const TesteApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.init();
  // Workmanager().cancelAll();
  await Workmanager().initialize(callbackDispatcher);

  runApp(const OnflyApp());
}
