import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestao_viajem_onfly/core/helpers/extension/date_time_extension.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';

import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/view/widget/dashed_line_widget.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/model/boarding_pass_model.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/view/widget/dashed_line_ticket_widget.dart';

class CardBoardingPassWidget extends StatelessWidget {
  final BoardingPassModel boardingPass;

  final Color? backgroundColor;
  final bool withShadow;
  const CardBoardingPassWidget({
    super.key,
    required this.boardingPass,
    this.backgroundColor,
    this.withShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppShapes.decoration(
          color: backgroundColor ?? appColors.white,
          radius: RadiusSize.medium,
          shadow: withShadow
              ? ShapesShadow(
                  ShadowSize.medium,
                  shadowColor: appColors.greyDark,
                )
              : null),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          SizedBox(
            height: 56,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: boardingPass.airlineCompany,
                        textStyle: AppTextStyle.paragraphMediumBold,
                        textColor: appColors.colorTextBlack,
                      ),
                      AppText(
                        text: boardingPass.number,
                        textStyle: AppTextStyle.paragraphMediumBold,
                        textColor: appColors.colorTextBlack,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: -10,
                  right: -10,
                  bottom: 0,
                  child: DashedLineTicketWidget(
                    mark: backgroundColor ?? appColors.whiteGrey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: boardingPass.origin.location,
                      textStyle: AppTextStyle.paragraphMedium,
                      textColor: appColors.colorTextBlackLight,
                    ),
                    AppText(
                      text: boardingPass.destination.location,
                      textStyle: AppTextStyle.paragraphMedium,
                      textColor: appColors.colorTextBlackLight,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: boardingPass.origin.acronym,
                      textStyle: AppTextStyle.paragraphMediumBold,
                      textColor: appColors.colorTextBlack,
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: LineVoo()),
                    ),
                    AppText(
                      text: boardingPass.destination.acronym,
                      textStyle: AppTextStyle.paragraphMediumBold,
                      textColor: appColors.colorTextBlack,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: boardingPass.departure.formatToBrazilianDate(),
                      textStyle: AppTextStyle.paragraphSmall,
                      textColor: appColors.colorTextBlackLight,
                    ),
                    AppText(
                      text: boardingPass.duration,
                      textStyle: AppTextStyle.paragraphSmall,
                      textColor: appColors.colorTextBlackLight,
                    ),
                    AppText(
                      text: boardingPass.arrival.formatToBrazilianDate(),
                      textStyle: AppTextStyle.paragraphSmall,
                      textColor: appColors.colorTextBlackLight,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget LineVoo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: AppShapes.decoration(
            radius: RadiusSize.circle,
            color: appColors.orange.withOpacity(0.3),
          ),
          child: Center(
            child: Container(
              height: 6,
              width: 6,
              decoration: AppShapes.decoration(
                radius: RadiusSize.circle,
                color: appColors.orange,
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              DashedLineWidget(
                height: 2,
                color: appColors.orange,
              ),
              Positioned(
                child: SvgPicture.asset(
                  'assets/svgs/ic_airplane.svg',
                  height: 16,
                  color: appColors.colorBrandPrimaryBlue,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 16,
          width: 16,
          decoration: AppShapes.decoration(
            radius: RadiusSize.circle,
            color: appColors.orange.withOpacity(0.3),
          ),
          child: Center(
            child: Container(
              height: 6,
              width: 6,
              decoration: AppShapes.decoration(
                radius: RadiusSize.circle,
                color: appColors.orange,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
