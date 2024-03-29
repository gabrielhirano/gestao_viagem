import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_viajem_onfly/core/component/large_button_app.dart';
import 'package:gestao_viajem_onfly/core/helper/extension/num_extension.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';
import 'package:gestao_viajem_onfly/feature/expense/controller/expense_controller.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/screen/expense_screen.dart';

class FloatingButtonTotalExpensesWidget extends StatefulWidget {
  final ExpenseController expenseController;
  const FloatingButtonTotalExpensesWidget(
      {super.key, required this.expenseController});

  @override
  State<FloatingButtonTotalExpensesWidget> createState() =>
      _FloatingButtonTotalExpensesWidgetState();
}

class _FloatingButtonTotalExpensesWidgetState
    extends State<FloatingButtonTotalExpensesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      width: MediaQuery.of(context).size.width - 30,
      padding: const EdgeInsets.all(10),
      decoration: AppShapes.decoration(
        radius: RadiusSize.medium,
        border: ShapesBorder(appColors.greyLight.withOpacity(0.2)),
        color: appColors.white,
      ),
      alignment: Alignment.center,
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
                    text:
                        widget.expenseController.totalSpend.realCurrencyNumber,
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
                ExpenseScreen(expenseController: widget.expenseController),
              );
            },
          )
        ],
      ),
    );
  }
}
