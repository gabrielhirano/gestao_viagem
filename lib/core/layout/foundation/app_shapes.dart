import 'package:flutter/material.dart';

enum RadiusSize { extraSmall, small, medium, large, extraLarge, circle }

enum ShadowSize { extraSmall, small, medium, large, extraLarge }

class ShapesShadow {
  ShadowSize shadowSize;
  Color shadowColor;
  ShapesShadow(this.shadowSize, {required this.shadowColor});

  List<BoxShadow> get build {
    return AppShapes.shadow(shadowSize, shadowColor: shadowColor);
  }
}

class ShapesBorder {
  Color borderColor;
  double borderWidth;
  ShapesBorder(this.borderColor, {this.borderWidth = 1});
  BoxBorder get build {
    return Border.all(color: borderColor, width: borderWidth);
  }
}

mixin AppShapes {
  //! Border Radius
  static BorderRadius radius(RadiusSize? radiusSize, {BorderRadius? borderCustom}) {
    const radiusExtraSmall = 4.0;
    double radius;

    Map<RadiusSize, double> sizes = {
      RadiusSize.extraSmall: radiusExtraSmall,
      RadiusSize.small: radiusExtraSmall * 2,
      RadiusSize.medium: radiusExtraSmall * 3,
      RadiusSize.large: radiusExtraSmall * 4,
      RadiusSize.extraLarge: radiusExtraSmall * 6,
      RadiusSize.circle: 1024,
    };

    radius = sizes[radiusSize] ?? 0;

    return borderCustom ?? BorderRadius.all(Radius.circular(radius));
  }

  //! Box Shadow
  static List<BoxShadow> shadow(ShadowSize shadowSize, {required Color shadowColor}) {
    Offset offset;
    double blurRadius;
    switch (shadowSize) {
      case ShadowSize.extraSmall:
        offset = const Offset(0, -0.5);
        blurRadius = 2.0;
        break;
      case ShadowSize.small:
        offset = const Offset(0, -2);
        blurRadius = 4.0;
        break;
      case ShadowSize.medium:
        offset = const Offset(1, 2);
        blurRadius = 8.0;
        break;
      case ShadowSize.large:
        offset = const Offset(0, 3);
        blurRadius = 9.0;
        break;
      case ShadowSize.extraLarge:
        offset = const Offset(0, 0);
        blurRadius = 20.0;
        break;
    }
    return [BoxShadow(color: shadowColor.withOpacity(0.08), offset: offset, blurRadius: blurRadius)];
  }

  //! Box Decoration
  static BoxDecoration decoration({
    Color? color,
    RadiusSize? radius,
    BorderRadius? customRadius,
    ShapesShadow? shadow,
    ShapesBorder? border,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: AppShapes.radius(radius, borderCustom: customRadius),
      boxShadow: shadow?.build,
      border: border?.build,
    );
  }
}
