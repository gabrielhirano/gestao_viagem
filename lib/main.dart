import 'package:flutter/material.dart';
import 'package:gestao_viajem_onfly/core/config/dependency_injection.dart';
import 'package:gestao_viajem_onfly/core/config/onfly_app.dart';
import 'package:gestao_viajem_onfly/core/service/work_manager_dispacher.dart';

import 'package:workmanager/workmanager.dart';

void callbackDispatcher() =>
    Workmanager().executeTask(WorkManagerDispacherService.dispatcher);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.init();

  await Workmanager().initialize(callbackDispatcher);

  runApp(const OnflyApp());
}
