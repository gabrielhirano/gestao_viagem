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
        title: AppText(
          text: 'Editar despesa  -  ${widget.expense.id}',
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

  void onEdit() {
    if (formKey.currentState?.validate() ?? false) {
      // passar isso para uma factory e tratar as possiveis exceções
      final newExpense = ExpenseModel(
        id: widget.expense.id,
        name: nameTextController.text,
        category: categoryController ?? ExpenseCategory.others,
        value: double.parse(valueTextController.text.replaceAll(',', '.')),
        date: DateFormat('dd/MM/yyyy').parse(dateTextController.text),
        comment: commentTextController.text,
      );

      widget.expenseController.updateExpense(newExpense).then((value) {
        // em caso de sucesso já atualizo a minha tela de expenses
        widget.expenseController.getExpenses();
        // Mostrar alguma mensagem de sucesso! um Toast provavelmente.
      }).catchError((error) => 'error'); // Mostrar Alerta de erro se houver

      appNavigator.popNavigate();
    }
  }
}
