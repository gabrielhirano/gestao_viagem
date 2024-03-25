import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gestao_viajem_onfly/core/component/large_button_app.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/util/app_state.dart';
import 'package:gestao_viajem_onfly/core/util/global.dart';
import 'package:gestao_viajem_onfly/feature/expense/controller/expense_controller.dart';
import 'package:gestao_viajem_onfly/feature/expense/model/expense_model.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/widget/drop_down/expense_category_drop_down_widget.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/widget/text_field/expense_comment_text_field_widget.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/widget/text_field/expense_date_text_field_widget.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/widget/text_field/expense_name_text_field_widget.dart';
import 'package:gestao_viajem_onfly/feature/expense/view/widget/text_field/expense_value_text_field_widget.dart';

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
  void dispose() {
    nameTextController.dispose();
    valueTextController.dispose();
    dateTextController.dispose();
    commentTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.colorBrandPrimaryBlue,
        title: AppText(
          text: 'Nova despesa',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
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
                    initialCategory: categoryController?.name ?? 'Categoria',
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

  void onSave() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState?.validate() == false) return;

    final newExpense = ExpenseModel.createExpenseFromForm(
      name: nameTextController.text,
      category: categoryController,
      value: valueTextController.text,
      date: dateTextController.text,
      comment: commentTextController.text,
    );

    if (newExpense == null) {
      // tratar algum possivel erro de conversão de dados;
      return;
    }

    onCreate(newExpense);
  }

  void onCreate(ExpenseModel expense) async {
    await widget.expenseController.createExpense(expense);

    if (widget.expenseController.state.getState == AppState.success) {
      widget.expenseController.getExpenses();
    }

    if (widget.expenseController.state.getState == AppState.error) {
      // Aqui seria para tratar as mensagens de erro ou fluxo de erro;
      final errorMessage = widget.expenseController.state.getError.message;
    }

    appNavigator.popNavigate();
  }
}
