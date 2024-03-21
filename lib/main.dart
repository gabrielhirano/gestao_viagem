import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/config/dependency_injection.dart';
import 'package:gestao_viajem/core/config/onfly_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const OnflyApp());
}
