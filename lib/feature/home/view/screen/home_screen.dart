import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_viajem_onfly/core/components/large_button_app.dart';

import 'package:gestao_viajem_onfly/core/controller/connectivity_controller.dart';
import 'package:gestao_viajem_onfly/core/util/app_state.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/helpers/extension/num_extension.dart';
import 'package:gestao_viajem_onfly/core/util/getit_global.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';

import 'package:gestao_viajem_onfly/core/view/loading_screen.dart';
import 'package:gestao_viajem_onfly/core/view/widget/offline_connection_widget.dart';
import 'package:gestao_viajem_onfly/feature/expense/controller/expense_controller.dart';
import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/screen/edit_expense_screen.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/screen/expense_screen.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/widget/expense_card_widget.dart';

import 'package:gestao_viajem_onfly/feature/home/view/widget/acess_card_report_widget.dart';
import 'package:gestao_viajem_onfly/feature/home/view/widget/acess_card_travel_widget.dart';
import 'package:gestao_viajem_onfly/feature/home/view/widget/acess_card_wallet_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ExpenseController expenseController;
  late final ConnectivityController connectivityController;

  @override
  void initState() {
    expenseController = getIt<ExpenseController>();
    connectivityController = getIt<ConnectivityController>();

    expenseController.getExpenses();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        backgroundColor: appColors.white,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            const AppText(
              text: 'Onfly',
              textStyle: AppTextStyle.headerH4,
            ),
            const SizedBox(width: 30),
            Observer(builder: (_) {
              return Visibility(
                visible: connectivityController.isOffline,
                child: const OfflineConnectionWidget(),
              );
            })
          ],
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
        height: 112,
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
                      textColor: appColors.colorTextBlack.withOpacity(0.9),
                    ),
                    const Spacer(),
                    Observer(builder: (_) {
                      return AppText(
                        text: expenseController.totalSpend.realCurrencyNumber,
                        textStyle: AppTextStyle.headerH4,
                        textColor: appColors.colorTextBlack.withOpacity(0.9),
                      );
                    }),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              LargeButtonApp(
                text: 'Adicionar despesa',
                color: appColors.orange,
                onPressed: () {
                  appNavigator.navigate(
                    ExpenseScreen(expenseController: expenseController),
                  );
                },
              )
            ],
          ),
        ),
      ),
      body: Observer(builder: (_) {
        return switch (expenseController.state.getState) {
          AppState.none => const LoadingScreen(),
          AppState.loading => const LoadingScreen(),
          AppState.empty => const Center(child: Text('Nenhum dado encontrado')),
          AppState.success =>
            _sucessState(expenseController.state.getData ?? []),
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
            (_, index) {
              final expense = expenses[index];
              return InkWell(
                  onTap: () {
                    // streamController.add({'data': 'change stream'});
                    appNavigator.navigate(EditExpenseScreen(
                      expense: expense,
                      expenseController: expenseController,
                    ));
                  },
                  child: ExpenseCardWidget(expense: expense));
            },
            childCount: expenses.length,
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 140)),
        ],
      ),
    );
  }
}
