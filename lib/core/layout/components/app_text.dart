import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';

import '../foundation/app_typography.dart';

enum AppTextStyle {
  /// fontSize: 40 / fontWeight: w500
  headerH1(AppTypography.typographyHeader1),

  /// fontSize: 32 / fontWeight: w500
  headerH2(AppTypography.typographyHeader2),

  /// fontSize: 24 / fontWeight: w500
  headerH3(AppTypography.typographyHeader3),

  /// fontSize: 18 / fontWeight: w500
  headerH4(AppTypography.typographyHeader4),

  /// fontSize: 12 / fontWeight: w400
  paragraphSmall(AppTypography.typographyParagraphSmall),

  /// fontSize: 12 / fontWeight: w500
  paragraphSmallBold(AppTypography.typographyParagraphSmallBold),

  /// fontSize: 14 / fontWeight: w400
  paragraphMedium(AppTypography.typographyParagraphMedium),

  /// fontSize: 14 / fontWeight: w500
  paragraphMediumBold(AppTypography.typographyParagraphMediumBold),

  /// fontSize: 16 / fontWeight: w400
  paragraphLarge(AppTypography.typographyParagraphLarge),

  /// fontSize: 16 / fontWeight: w500
  paragraphLargeBold(AppTypography.typographyParagraphLargeBold),

  /// fontSize: 20 / fontWeight: w500
  paragraphExtrLarge(AppTypography.typographyParagrapExtraLarge),

  /// fontSize: 20 / fontWeight: w600
  paragraphExtrLargeBold(AppTypography.typographyParagraphLargeBold);

  const AppTextStyle(this.appTypographyStyle);
  final TextStyle appTypographyStyle;
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextStyle textStyle;
  final TextAlign textAlign;
  final Color? textColor;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final bool isSelectable;

  const AppText({
    Key? key,
    required this.text,
    required this.textStyle,
    this.textAlign = TextAlign.left,
    this.textColor,
    this.textOverflow,
    this.textDecoration,
    this.maxLines,
    this.isSelectable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSelectable) {
      return SelectableText(
        _formattedText,
        style: _fromAppStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        showCursor: false,
      );
    }
    return Text(_formattedText,
        style: _fromAppStyle,
        overflow: textOverflow,
        textAlign: textAlign,
        maxLines: maxLines);
  }

  String get _formattedText {
    return text;
  }

  TextStyle get _fromAppStyle {
    TextStyle convertedTextStyle = textStyle.appTypographyStyle;

    convertedTextStyle = convertedTextStyle.copyWith(
        color: textColor ??
            appColors
                .colorBrandPrimaryBlue); // definir uma variavel de color para text

    if (textDecoration != null) {
      convertedTextStyle =
          convertedTextStyle.copyWith(decoration: textDecoration);
    }
    return convertedTextStyle;
  }
}
