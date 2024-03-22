import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gestao_viajem/core/components/large_button_app.dart';
import 'package:gestao_viajem/core/layout/components/app_text.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';
import 'package:gestao_viajem/core/util/global.dart';
import 'package:gestao_viajem/feature/expense/controller/expense_controller.dart';
import 'package:gestao_viajem/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem/feature/expense/view/widget/drop_down/expense_category_drop_down_widget.dart';
import 'package:gestao_viajem/feature/expense/view/widget/text_field/expense_comment_text_field_widget.dart';
import 'package:gestao_viajem/feature/expense/view/widget/text_field/expense_date_text_field_widget.dart';
import 'package:gestao_viajem/feature/expense/view/widget/text_field/expense_name_text_field_widget.dart';
import 'package:gestao_viajem/feature/expense/view/widget/text_field/expense_value_text_field_widget.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  final ExpenseController expenseController;
  const ExpenseScreen({super.key, required this.expenseController});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final valueTextController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
  );
  final dateTextController = MaskedTextController(mask: '00/00/0000');
  final commentTextController = TextEditingController();
  ExpenseCategory? categoryController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: 'Nova despesa',
          textStyle: AppTextStyle.paragraphLargeBold,
          textColor: appColors.colorTextBlack,
        ),
        leading: InkWell(
          onTap: appNavigator.popNavigate,
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: appColors.colorTextBlack,
            size: 36,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: ExpenseNameTextField(
                  controller: nameTextController,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: ExpenseValueTextField(
                  controller: valueTextController,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: ExpenseCategoryDropDownWidget(
                    onSelect: (category) => categoryController = category),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: ExpenseDateTextField(
                  controller: dateTextController,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: ExpenseCommentTextField(
                  controller: commentTextController,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: LargeButtonApp(
                  color: appColors.orange,
                  text: 'Salvar',
                  onPressed: onSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSave() {
    if (formKey.currentState?.validate() ?? false) {
      // passar isso para uma factory e tratar as possiveis exceções
      final newExpense = ExpenseModel(
        name: nameTextController.text,
        category: categoryController ?? ExpenseCategory.others,
        value: double.parse(valueTextController.text.replaceAll(',', '.')),
        date: DateFormat('dd/MM/yyyy').parse(dateTextController.text),
        comment: commentTextController.text,
      );

      widget.expenseController.registerExpense(newExpense).then((value) {
        widget.expenseController
            .getExpenses(); // em caso de sucesso já atualizo a minha tela de expenses
        // Mostrar alguma mensagem de sucesso um Toast provavelmente
      }).catchError((error) => 'error');

      // Mostrar Alerta de erro se houver
      appNavigator.popNavigate();
    }
  }
}
