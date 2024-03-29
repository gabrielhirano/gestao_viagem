import 'package:flutter/material.dart';

import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';

import 'package:gestao_viajem_onfly/feature/expense/controller/expense_controller.dart';
import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/screen/edit_expense_screen.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/widget/expense_card_widget.dart';
import 'package:gestao_viajem_onfly/feature/home/view/widget/acess_card/acess_card_report_widget.dart';
import 'package:gestao_viajem_onfly/feature/home/view/widget/acess_card/acess_card_travel_widget.dart';
import 'package:gestao_viajem_onfly/feature/home/view/widget/acess_card/acess_card_wallet_widget.dart';

class HomeSucessState extends StatefulWidget {
  final List<ExpenseModel> expenses;
  final ExpenseController expenseController;
  const HomeSucessState(
      {super.key, required this.expenses, required this.expenseController});

  @override
  State<HomeSucessState> createState() => _HomeSucessStateState();
}

class _HomeSucessStateState extends State<HomeSucessState> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: Container(
              height: 140,
              decoration: AppShapes.decoration(
                color: appColors.colorBrandPrimaryBlue,
                customRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: AppText(
                      text: 'Acessos',
                      textStyle: AppTextStyle.paragraphMediumBold,
                      textColor: appColors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AcessCardTravelWidget(),
                      AcessCardWalletWidget(),
                      AcessCardReportWidget(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        // const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(
          child: Container(
            color: appColors.white,
            padding: const EdgeInsets.all(20),
            child: AppText(
              text: 'Ultimas despesas',
              textStyle: AppTextStyle.paragraphMediumBold,
              textColor: appColors.colorTextBlack,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (_, index) {
            final expense = widget.expenses[index];
            return InkWell(
                onTap: () {
                  appNavigator.navigate(EditExpenseScreen(
                    expense: expense,
                    expenseController: widget.expenseController,
                  ));
                },
                child: Container(
                    color: appColors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ExpenseCardWidget(expense: expense)));
          },
          childCount: widget.expenses.length,
        )),
        SliverToBoxAdapter(
            child: Container(color: appColors.white, height: 140)),
      ],
    );
  }
}
