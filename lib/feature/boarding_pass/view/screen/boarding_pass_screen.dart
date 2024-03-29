import 'package:flutter/material.dart';
import 'package:gestao_viajem_onfly/core/helper/extension/date_time_extension.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/model/boarding_pass_model.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/view/widget/card_boarding_field_widget.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/view/widget/card_boarding_pass_widget.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/view/widget/dashed_line_ticket_widget.dart';

class BoardingPassScreen extends StatelessWidget {
  final BoardingPassModel boardingPass;

  const BoardingPassScreen({
    super.key,
    required this.boardingPass,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.whiteGrey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: appColors.colorBrandPrimaryBlue,
        centerTitle: true,
        title: AppText(
          text: 'Cartão de embarque',
          textStyle: AppTextStyle.paragraphLargeBold,
          textColor: appColors.white,
        ),
        leading: InkWell(
          onTap: appNavigator.popNavigate,
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: appColors.white,
            size: 32,
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: appColors.colorBrandPrimaryBlue,
            ),
            Container(
              width: double.infinity,
              height: 500,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 100),
              decoration: AppShapes.decoration(
                  color: appColors.white,
                  radius: RadiusSize.medium,
                  shadow: ShapesShadow(
                    ShadowSize.medium,
                    shadowColor: appColors.greyDark,
                  )),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CardBoardingPassWidget(
                        boardingPass: boardingPass,
                        backgroundColor: appColors.white,
                      ),
                      Positioned(
                        left: -10,
                        right: -10,
                        bottom: 0,
                        child:
                            DashedLineTicketWidget(mark: appColors.whiteGrey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Passageiro',
                          textStyle: AppTextStyle.paragraphSmall,
                          textColor: appColors.colorTextBlackLight,
                        ),
                        AppText(
                          text: boardingPass.passenger,
                          textStyle: AppTextStyle.paragraphMediumBold,
                          textColor: appColors.colorTextBlackLight,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CardBoardingFieldWidget(
                                title: 'Embarque',
                                info: boardingPass
                                    .departure.formatToBrazilianTime,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CardBoardingFieldWidget(
                                title: 'Desembarque',
                                info:
                                    boardingPass.arrival.formatToBrazilianTime,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CardBoardingFieldWidget(
                                title: 'Assento ',
                                info: boardingPass.seat,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CardBoardingFieldWidget(
                                title: 'Terminal',
                                info: boardingPass.terminal,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CardBoardingFieldWidget(
                                title: 'Portão',
                                info: boardingPass.gate,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const DashedLineTicketWidget(),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: AppShapes.decoration(
                        color: Colors.grey.withOpacity(0.1)),
                    child: const Center(
                      child: Text('Codigo de barras'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
