import 'package:flutter/material.dart';
import 'package:gestao_viajem_onfly/core/components/input_form_app.dart';
import 'package:gestao_viajem_onfly/core/helpers/validator/input_validator.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';

class ExpenseValueTextField extends StatefulWidget {
  final TextEditingController controller;
  const ExpenseValueTextField({super.key, required this.controller});

  @override
  State<ExpenseValueTextField> createState() => _ExpenseValueTextFieldState();
}

class _ExpenseValueTextFieldState extends State<ExpenseValueTextField>
    with InputValidator {
  @override
  Widget build(BuildContext context) {
    return InputFormApp(
      controller: widget.controller,
      borderColor: appColors.greyLight,
      placeholder: 'Valor',
      inputType: TextInputType.number,
      validator: _validateValueExpense,
    );
  }

  String? _validateValueExpense(String? value) {
    List<String? Function()> validators = [
      () => isNotEmpty(value ?? ''),
      () => validateNoTrailingSpaces(value ?? ''),
    ];

    return combine(validators);
  }
}
