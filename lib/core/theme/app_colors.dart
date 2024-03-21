import 'package:flutter/material.dart';

abstract class IAppColors {
  // Brands - Primary
  final colorBrandPrimaryBlue = const Color(0xFF187BFF);
  final colorBrandPrimaryBlueLight = const Color(0xFF5AB7F5);

  // Feedback
  final colorFeedbackPositive = const Color(0xFF48A700);
  final colorFeedbackError = const Color(0xFFFC5B5B);
  final colorFeedbackAlert = const Color(0xFFFFBF99);

  final colorTextBlack = const Color(0xFF424242);
  final colorTextBlackLight = const Color(0xFF8E8E8E);

  // Generics
  final white = const Color(0xFFFFFFFF);
  final black = const Color(0xFF000000);
  final blue = const Color(0xFF32759A);

  final transparent = Colors.transparent;

  // Generics - Dark
  final greyDark = const Color(0xFF4A4A4A);
}

class AppColors extends IAppColors {}
