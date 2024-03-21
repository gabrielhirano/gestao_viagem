import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/config/dependency_injection.dart';
import 'package:gestao_viajem/core/util/app_navigator.dart';
import 'package:gestao_viajem/core/view/loading_screen.dart';
import 'package:gestao_viajem/feature/authentication/view/screen/login_screen.dart';
import 'package:gestao_viajem/feature/home/view/screen/home_screen.dart';
import 'package:gestao_viajem/feature/home/view/screen/main_screen.dart';

class OnflyApp extends StatefulWidget {
  const OnflyApp({super.key});

  @override
  State<OnflyApp> createState() => _OnflyAppState();
}

class _OnflyAppState extends State<OnflyApp> {
  @override
  void initState() {
    getIt<AppNavigator>().context = context;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoadingScreen(),
      // home: MainScreen(),
      home: HomeScreen(),
    );
  }
}
