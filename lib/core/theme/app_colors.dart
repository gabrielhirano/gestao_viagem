import 'package:flutter/material.dart';

abstract class IAppColors {
  // Brands - Primary
  final colorBrandPrimaryBlue = const Color(0xFF2a9efb);
  final colorBrandPrimaryBlueLight = const Color(0xFF5AB7F5);

  final colorBrandSecondaryGreen = const Color(0xFF26a69a);

  // Background
  final colorBackgroundWhite = const Color(0xFFf2f2f2);

  // Feedback
  final colorFeedbackPositive = const Color(0xFF21ba45);
  final colorFeedbackNegative = const Color(0xFFc10015);
  final colorFeedbackInfo = const Color(0xFF31ccec);
  final colorFeedbackWarning = const Color(0xFFf2c037);

  final colorTextBlack = const Color(0xFF484554);
  final colorTextBlackLight = Color.fromARGB(255, 12, 42, 66);

  // Generics
  final white = const Color(0xFFFFFFFF);
  final black = const Color(0xFF000000);
  final blue = const Color(0xFF32759A);

  final transparent = Colors.transparent;

  final greyLight = const Color(0xFF4A4A4A).withOpacity(0.3);

  // Generics - Dark
  final greyDark = const Color(0xFF4A4A4A);
}

class AppColors extends IAppColors {}
