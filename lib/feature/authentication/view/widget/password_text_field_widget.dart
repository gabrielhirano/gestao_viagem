import 'package:flutter/material.dart';

import 'package:gestao_viajem_onfly/feature/authentication/model/password_model.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  const PasswordTextFieldWidget({super.key, required this.controller});

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return InputFormApp(
    //   controller: widget.controller,

    //   obscureText: true,
    //   prefixIcon: const Icon(Icons.lock_outline_sharp, size: 22),
    //   validator: _validatePassword,
    // );
  }

  String? _validatePassword(String? value) {
    final passwordModel = PasswordModel(value ?? '');

    return passwordModel.validate();
  }
}
