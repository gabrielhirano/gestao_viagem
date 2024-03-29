import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';

import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/util/app_state.dart';
import 'package:gestao_viajem_onfly/core/util/getit_global.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';
import 'package:gestao_viajem_onfly/core/view/loading_screen.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/controller/boarding_pass_controller.dart';

import 'package:gestao_viajem_onfly/feature/boarding_pass/view/screen/boarding_pass_screen/boarding_pass_screen.dart';
import 'package:gestao_viajem_onfly/feature/boarding_pass/view/widget/card_boarding_pass_widget.dart';

class TravelsScreen extends StatefulWidget {
  const TravelsScreen({super.key});

  @override
  State<TravelsScreen> createState() => _TravelsScreenState();
}

class _TravelsScreenState extends State<TravelsScreen> {
  late BoardingPassController boardingPassController;

  @override
  void initState() {
    boardingPassController = getIt<BoardingPassController>();

    boardingPassController.getBoardingPasses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (boardingPassController.state.getState == AppState.loading) {
        return const LoadingScreen();
      }

      return Scaffold(
        backgroundColor: appColors.whiteGrey,
        appBar: AppBar(
          backgroundColor: appColors.colorBrandPrimaryBlue,
          title: AppText(
            text: 'Minhas viagens',
            textStyle: AppTextStyle.headerH4,
            textColor: appColors.white,
          ),
          iconTheme: IconThemeData(color: appColors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    final boardingPass =
                        boardingPassController.state.getData?[index];

                    if (boardingPass == null) return const SizedBox.shrink();

                    return CardBoardingPassWidget(
                      boardingPass: boardingPass,
                      withShadow: true,
                      onTap: () => appNavigator.navigate(
                        BoardingPassScreen(boardingPass: boardingPass),
                      ),
                    );
                  },
                  childCount: boardingPassController.state.getData?.length,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
