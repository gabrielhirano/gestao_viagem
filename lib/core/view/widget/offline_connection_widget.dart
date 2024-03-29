import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';

class OfflineConnectionWidget extends StatelessWidget {
  const OfflineConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppShapes.decoration(
        radius: RadiusSize.circle,
        color: appColors.colorFeedbackNegative,
      ),
      width: 122,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            'assets/svgs/ic_offline.svg',
            height: 24,
            color: appColors.white,
          ),
          AppText(
            text: 'Offline',
            textStyle: AppTextStyle.paragraphMediumBold,
            textColor: appColors.white,
          ),
        ],
      ),
    );
  }
}
