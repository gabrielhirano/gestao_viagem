import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';

class AcessCardWalletWidget extends StatelessWidget {
  const AcessCardWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: AppShapes.decoration(
        radius: RadiusSize.medium,
        color: appColors.colorBrandPrimaryBlue.withOpacity(0.07),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/svgs/ic_wallet.svg',
            height: 24,
            color: appColors.colorBrandPrimaryBlue,
          ),
          const SizedBox(height: 10),
          AppText(
            text: 'Carteira',
            textStyle: AppTextStyle.paragraphSmallBold,
            textColor: appColors.colorTextBlack,
          )
        ],
      ),
    );
  }
}
