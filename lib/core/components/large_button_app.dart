import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/layout/components/app_text.dart';
import 'package:gestao_viajem/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';

class LargeButtonApp extends StatelessWidget {
  final Color color;
  final String text;
  final Function() onPressed;
  const LargeButtonApp(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration:
            AppShapes.decoration(radius: RadiusSize.medium, color: color),
        child: Center(
          child: AppText(
            text: text,
            textStyle: AppTextStyle.paragraphLargeBold,
            textColor: appColors.white,
          ),
        ),
      ),
    );
  }
}
