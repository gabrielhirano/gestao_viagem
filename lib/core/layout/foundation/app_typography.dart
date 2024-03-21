import 'package:flutter/painting.dart';

mixin AppTypography {
  static const fontFamily = 'Montserrat';

  static const typographyHeader1 = TextStyle(
    fontSize: 40,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );

  static const typographyHeader2 = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );

  static const typographyHeader3 = TextStyle(
    fontSize: 24,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );

  static const typographyHeader4 = TextStyle(
    fontSize: 18,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );

  static const typographyParagraphSmall = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const typographyParagraphSmallBold = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );

  static const typographyParagraphMedium = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
  );

  static const typographyParagraphMediumBold = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );

  static const typographyParagraphLarge = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const typographyParagraphLargeBold = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
  );

  static const typographyParagrapExtraLarge = TextStyle(
    fontSize: 20,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const typographyParagrapExtraLargeBold = TextStyle(
    fontSize: 20,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );
}
