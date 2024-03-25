import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';

class AcessCardWalletWidget extends StatelessWidget {
  const AcessCardWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            'assets/svgs/ic_wallet.svg',
            height: 24,
            color: appColors.colorBrandPrimaryBlue,
          ),
        ),
        const SizedBox(height: 10),
        AppText(
          text: 'Cartões',
          textStyle: AppTextStyle.paragraphSmallBold,
          textColor: appColors.white,
        )
      ],
    );
  }
}
