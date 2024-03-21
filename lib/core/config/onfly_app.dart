import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: LoadingScreen(),
      home: MainScreen(),
      // home: LoginScreen(),
    );
  }
}
