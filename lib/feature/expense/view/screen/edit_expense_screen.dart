import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gestao_viajem_onfly/core/components/large_button_app.dart';
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

class EditExpenseScreen extends StatefulWidget {
  final ExpenseController expenseController;
  final ExpenseModel expense;

  const EditExpenseScreen({
    super.key,
    required this.expenseController,
    required this.expense,
  });

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
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
  void initState() {
    nameTextController.text = widget.expense.name;
    valueTextController.text = widget.expense.value.toString();
    dateTextController.text = widget.expense.dateFormated;
    commentTextController.text = widget.expense.comment ?? '';
    categoryController = widget.expense.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.colorBrandPrimaryBlue,
        title: AppText(
          text: 'Editar despesa  -  ${widget.expense.id}',
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
                    initialCategory: categoryController?.name,
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
                  text: 'Editar',
                  onPressed: onEdit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onEdit() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState?.validate() == false) return;

    final changedExpense = ExpenseModel.createExpenseFromForm(
      id: widget.expense.id,
      name: nameTextController.text,
      category: categoryController,
      value: valueTextController.text,
      date: dateTextController.text,
      comment: commentTextController.text,
    );

    if (changedExpense == null) {
      // tratar algum possivel erro de conversão de dados;
      return;
    }

    onUpdate(changedExpense);
  }

  void onUpdate(ExpenseModel expense) async {
    await widget.expenseController.updateExpense(expense);

    if (widget.expenseController.state.getState == AppState.success) {
      widget.expenseController.getExpenses();
    }

    if (widget.expenseController.state.getState == AppState.error) {
      // Aqui seria para tratar as mensagens de erro ou fluxo de erro;
      final errorMessage = widget.expenseController.state.getError.message;
      print(errorMessage);
    }

    appNavigator.popNavigate();
  }
}
