import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_viajem/core/config/dependency_injection.dart';
import 'package:gestao_viajem/core/helpers/app_state.dart';
import 'package:gestao_viajem/core/layout/components/app_text.dart';
import 'package:gestao_viajem/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';
import 'package:gestao_viajem/core/util/num_extension.dart';
import 'package:gestao_viajem/core/util/string_extension.dart';
import 'package:gestao_viajem/core/view/loading_screen.dart';
import 'package:gestao_viajem/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem/feature/expense/view/widget/expense_card_widget.dart';

import 'package:gestao_viajem/feature/home/controller/home_controller.dart';
import 'package:gestao_viajem/feature/home/view/widget/acess_card_report_widget.dart';
import 'package:gestao_viajem/feature/home/view/widget/acess_card_travel_widget.dart';
import 'package:gestao_viajem/feature/home/view/widget/acess_card_wallet_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController controller;

  @override
  void initState() {
    controller = getIt<HomeController>();
    controller.getExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        title: const AppText(
          text: 'Onfly',
          textStyle: AppTextStyle.headerH4,
        ),
        actions: const [
          Icon(Icons.notifications),
          SizedBox(width: 20),
          Icon(Icons.person),
          SizedBox(width: 12),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        height: 110,
        width: MediaQuery.of(context).size.width - 30,
        decoration: AppShapes.decoration(
          radius: RadiusSize.medium,
          border: ShapesBorder(appColors.greyLight.withOpacity(0.2)),
          color: appColors.white,
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    AppText(
                      text: 'Total gasto: ',
                      textStyle: AppTextStyle.paragraphExtrLargeBold,
                      textColor: appColors.colorTextBlackLight,
                    ),
                    const Spacer(),
                    Observer(builder: (_) {
                      return AppText(
                        text: controller.totalSpend.realCurrencyNumber,
                        textStyle: AppTextStyle.headerH4,
                        textColor: appColors.colorTextBlack.withOpacity(0.9),
                      );
                    }),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                decoration: AppShapes.decoration(
                    radius: RadiusSize.medium, color: appColors.orange),
                child: Center(
                  child: AppText(
                    text: 'Adicionar despesa',
                    textStyle: AppTextStyle.paragraphExtrLargeBold,
                    textColor: appColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Observer(builder: (_) {
        return switch (controller.state.getState) {
          AppState.none => const LoadingScreen(),
          AppState.loading => const LoadingScreen(),
          AppState.empty => const Center(child: Text('Nenhum dado encontrado')),
          AppState.success => _sucessState(controller.state.getData ?? []),
          AppState.error => const Center(child: Text('Tela de erro')),
        };
      }),
    );
  }

  Widget _sucessState(List<ExpenseModel> expenses) {
    print(expenses);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppText(
              text: 'Acessos',
              textStyle: AppTextStyle.paragraphMediumBold,
              textColor: appColors.colorTextBlack,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AcessCardTravelWidget(),
                AcessCardWalletWidget(),
                AcessCardReportWidget(),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: AppText(
              text: 'Ultimas despesas',
              textStyle: AppTextStyle.paragraphMediumBold,
              textColor: appColors.colorTextBlack,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (_, index) => ExpenseCardWidget(expense: expenses[index]),
            childCount: expenses.length,
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 140)),
        ],
      ),
    );
    // return ListView.builder(
    //   itemCount: expenses.length,
    //   itemBuilder: (_, index) {
    //     final post = expenses[index];
    //     return InkWell(
    //       onTap: controller.postPost,
    //       child: Container(
    //         height: 100,
    //         width: double.infinity,
    //         decoration: AppShapes.decoration(
    //           color: Colors.redAccent,
    //         ),
    //         margin: const EdgeInsets.only(bottom: 10),
    //         child: Center(
    //           child: AppText(
    //               text: '${post.title}',
    //               textStyle: AppTextStyle.paragraphMediumBold,
    //               textColor: appColors.white),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
