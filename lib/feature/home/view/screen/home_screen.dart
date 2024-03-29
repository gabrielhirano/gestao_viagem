import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_viajem_onfly/core/controller/connectivity_controller.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';

import 'package:gestao_viajem_onfly/core/util/app_state.dart';
import 'package:gestao_viajem_onfly/core/util/getit_global.dart';

import 'package:gestao_viajem_onfly/core/view/loading_screen.dart';
import 'package:gestao_viajem_onfly/core/view/widget/offline_connection_widget.dart';
import 'package:gestao_viajem_onfly/feature/expense/controller/expense_controller.dart';

import 'package:gestao_viajem_onfly/feature/home/view/widget/floating_button_total_expenses_widget.dart';
import 'package:gestao_viajem_onfly/feature/home/view/widget/home_sucess_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ExpenseController expenseController;
  late ConnectivityController connectivityController;

  @override
  void initState() {
    expenseController = getIt<ExpenseController>();
    connectivityController = getIt<ConnectivityController>();

    expenseController.getExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Visibility(
        visible: expenseController.state.getState != AppState.loading,
        replacement: const LoadingScreen(
          key: ValueKey('LoadingHomeScreen'),
        ),
        child: Scaffold(
          body: switch (expenseController.state.getState) {
            AppState.none => SizedBox.fromSize(),
            AppState.loading => SizedBox.fromSize(),
            AppState.empty => const Center(
                child: Text('Nenhum dado encontrado'),
              ),
            AppState.success => HomeSucessState(
                key: const ValueKey('HomeSucessState'),
                expenses: expenseController.state.getData ?? [],
                expenseController: expenseController,
              ),
            AppState.error => const Center(
                child: Text('Tela de erro'),
              ),
          },
          appBar: AppBar(
            backgroundColor: appColors.colorBrandPrimaryBlue,
            shadowColor: appColors.colorBrandPrimaryBlue,
            iconTheme: IconThemeData(color: appColors.white),
            title: Row(
              children: [
                AppText(
                  text: 'Onfly',
                  textStyle: AppTextStyle.headerH4,
                  textColor: appColors.white,
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
          floatingActionButton: Visibility(
            visible: expenseController.state.getState != AppState.error,
            child: FloatingButtonTotalExpensesWidget(
              expenseController: expenseController,
            ),
          ),
        ),
      );
    });
  }
}
