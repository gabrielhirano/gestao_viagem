import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/components/input_form_app.dart';
import 'package:gestao_viajem/core/helpers/validator/input_validator.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ExpenseDateTextField extends StatefulWidget {
  final MaskedTextController controller;
  const ExpenseDateTextField({super.key, required this.controller});

  @override
  State<ExpenseDateTextField> createState() => _ExpenseDateTextFieldState();
}

class _ExpenseDateTextFieldState extends State<ExpenseDateTextField>
    with InputValidator {
  @override
  Widget build(BuildContext context) {
    return InputFormApp(
      controller: widget.controller,
      borderColor: appColors.greyLight,
      inputType: TextInputType.datetime,
      maxLength: 10,
      placeholder: 'Data',
      validator: _validateDateExpense,
    );
  }

  String? _validateDateExpense(String? value) {
    List<String? Function()> validators = [
      () => isNotEmpty(value ?? ''),
      () => validateNoTrailingSpaces(value ?? ''),
    ];

    return combine(validators);
  }
}
