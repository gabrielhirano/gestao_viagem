import 'package:flutter/material.dart';

class AppNavigator {
  late final BuildContext _context;
  set context(BuildContext context) => _context = context;
  AppNavigator();

  void navigate(dynamic destination) {
    Navigator.push(
      _context,
      MaterialPageRoute(
          builder: (context) => destination,
          fullscreenDialog: false,
          maintainState: false),
    );
  }

  void popNavigate() => Navigator.pop(_context);

  void popToRoot() => Navigator.popUntil(_context, (route) => route.isFirst);
}
