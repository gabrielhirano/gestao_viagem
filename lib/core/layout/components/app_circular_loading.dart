import 'package:flutter/material.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';

class AppCircularLoading extends StatelessWidget {
  static const _defaultStrokeWidth = 4.0;

  final Color? loadingColor;
  final Color? backgroundColor;
  final double strokeWidth;
  final bool isCenter;

  const AppCircularLoading({
    Key? key,
    this.loadingColor,
    this.backgroundColor,
    this.strokeWidth = _defaultStrokeWidth,
    this.isCenter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isCenter) {
      return Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(
              loadingColor ?? appColors.colorBrandPrimaryBlueLight),
          backgroundColor: backgroundColor ?? appColors.colorBrandPrimaryBlue,
          strokeWidth: strokeWidth,
        ),
      );
    }
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(
          loadingColor ?? appColors.colorBrandPrimaryBlueLight),
      backgroundColor: backgroundColor ?? appColors.colorBrandPrimaryBlue,
      strokeWidth: strokeWidth,
    );
  }
}
