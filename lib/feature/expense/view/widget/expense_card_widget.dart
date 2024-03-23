import 'package:flutter/material.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/helpers/extension/num_extension.dart';
import 'package:gestao_viajem_onfly/core/helpers/extension/string_extension.dart';
import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';

class ExpenseCardWidget extends StatelessWidget {
  final ExpenseModel expense;
  const ExpenseCardWidget({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: AppShapes.decoration(
        radius: RadiusSize.small,
        border: ShapesBorder(appColors.greyLight.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: expense.dateFormated,
                textStyle: AppTextStyle.paragraphSmall,
                textColor: appColors.colorTextBlack,
              ),
              AppText(
                text: expense.hour,
                textStyle: AppTextStyle.paragraphSmall,
                textColor: appColors.colorTextBlack,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: AppShapes.decoration(
                  radius: RadiusSize.circle,
                  color: appColors.orange.withOpacity(0.07),
                ),
                child: Icon(Icons.receipt, color: appColors.orange),
              ),
              const SizedBox(width: 16),
              AppText(
                text: expense.name,
                textStyle: AppTextStyle.paragraphLargeBold,
                textColor: appColors.colorTextBlack,
              ),
              const Spacer(),
              AppText(
                text: expense.value.realCurrencyNumber,
                textStyle: AppTextStyle.paragraphLargeBold,
                textColor: appColors.colorTextBlack,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 56),
            child: AppText(
              text: expense.category.name.capitalize,
              textStyle: AppTextStyle.paragraphSmall,
              textColor: appColors.colorTextBlack,
            ),
          ),
        ],
      ),
    );
  }
}
