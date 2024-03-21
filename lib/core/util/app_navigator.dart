import 'package:flutter/material.dart';

class AppNavigator {
  late GlobalKey<NavigatorState> _navigatorKey;

  set navigatorKey(GlobalKey<NavigatorState> navigatorKey) =>
      _navigatorKey = navigatorKey;

  void navigate(Widget destination) {
    _navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (context) => destination));
  }

  popNavigate() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
    }
  }

  popToRoot() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState
          ?.popUntil((Route<dynamic> route) => route.isFirst);
    }
  }
}
