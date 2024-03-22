import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/components/input_form_app.dart';
import 'package:gestao_viajem/core/helpers/validator/input_validator.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';

class ExpenseNameTextField extends StatefulWidget {
  final TextEditingController controller;
  const ExpenseNameTextField({super.key, required this.controller});

  @override
  State<ExpenseNameTextField> createState() => _ExpenseNameTextFieldState();
}

class _ExpenseNameTextFieldState extends State<ExpenseNameTextField>
    with InputValidator {
  @override
  Widget build(BuildContext context) {
    return InputFormApp(
      controller: widget.controller,
      borderColor: appColors.greyLight,
      placeholder: 'Nome',
      validator: _validateNameExpense,
    );
  }

  String? _validateNameExpense(String? value) {
    List<String? Function()> validators = [
      () => isNotEmpty(value ?? ''),
      () => validateNoTrailingSpaces(value ?? ''),
    ];

    return combine(validators);
  }
}
