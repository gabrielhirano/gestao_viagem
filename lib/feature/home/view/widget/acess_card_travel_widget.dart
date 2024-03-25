import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/view/screen/travels_screen.dart';

class AcessCardTravelWidget extends StatelessWidget {
  const AcessCardTravelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        appNavigator.navigate(TravelsScreen());
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(16),
            decoration: AppShapes.decoration(
              radius: RadiusSize.small,
              color: appColors.white,
            ),
            child: SvgPicture.asset(
              'assets/svgs/ic_ticket.svg',
              height: 24,
              color: appColors.colorBrandPrimaryBlue,
            ),
          ),
          const SizedBox(height: 10),
          AppText(
            text: 'Viagens',
            textStyle: AppTextStyle.paragraphSmallBold,
            textColor: appColors.white,
          )
        ],
      ),
    );
  }
}
