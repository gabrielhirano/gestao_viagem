import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/helpers/extension/string_extension.dart';
import 'package:gestao_viajem/core/layout/components/app_text.dart';
import 'package:gestao_viajem/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';
import 'package:gestao_viajem/core/util/global.dart';

import 'package:gestao_viajem/feature/expense/model/expense_model.dart';

class ExpenseCategoryDropDownWidget extends StatefulWidget {
  final String? initialCategory;
  final void Function(ExpenseCategory? category) onSelect;
  const ExpenseCategoryDropDownWidget(
      {super.key, required this.onSelect, required this.initialCategory});

  @override
  State<ExpenseCategoryDropDownWidget> createState() =>
      _ExpenseCategoryDropDownWidgetState();
}

class _ExpenseCategoryDropDownWidgetState
    extends State<ExpenseCategoryDropDownWidget> {
  ExpenseCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showAlertDialog(context),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: AppShapes.decoration(
          radius: RadiusSize.medium,
          color: appColors.white,
          border: ShapesBorder(appColors.greyLight, borderWidth: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: (_selectedCategory?.name ??
                      widget.initialCategory ??
                      'Categoria')
                  .capitalize,
              textStyle:
                  (_selectedCategory != null || widget.initialCategory != null)
                      ? AppTextStyle.paragraphLargeBold
                      : AppTextStyle.paragraphLarge,
              textColor:
                  (_selectedCategory != null || widget.initialCategory != null)
                      ? appColors.colorBrandPrimaryBlue
                      : appColors.colorTextBlack.withOpacity(0.9),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: appColors.colorTextBlack.withOpacity(0.9),
              size: 28,
            )
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appColors.white,
          clipBehavior: Clip.hardEdge,
          title: AppText(
            text: 'Categorias',
            textStyle: AppTextStyle.headerH4,
            textColor: appColors.colorBrandPrimaryBlue,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 200,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = ExpenseCategory.values[index];
                      return InkWell(
                        onTap: () {
                          setState(() => _selectedCategory = category);
                          widget.onSelect(category);
                          appNavigator.popNavigate();
                        },
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 20, right: 20),
                          child: Center(
                            child: AppText(
                              text: category.name.capitalize,
                              textStyle: AppTextStyle.paragraphLarge,
                              textColor:
                                  appColors.colorTextBlack.withOpacity(0.8),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: ExpenseCategory.values.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
