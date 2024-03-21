import 'package:flutter/material.dart';
import 'package:gestao_viajem/core/components/input_form_app.dart';
import 'package:gestao_viajem/feature/authentication/model/email_model.dart';

class EmailTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  const EmailTextFieldWidget({super.key, required this.controller});

  @override
  State<EmailTextFieldWidget> createState() => _EmailTextFieldWidgetState();
}

class _EmailTextFieldWidgetState extends State<EmailTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return InputFormApp(
      controller: widget.controller,
      label: 'Login',
      placeholder: 'Seu usuário, telefone, ou e-mail',
      prefixIcon: const Icon(Icons.person_outline_sharp, size: 24),
      validator: _validateEmail,
    );
  }

  String? _validateEmail(String? value) {
    final emailModel = EmailModel(value ?? '');
    return emailModel.validate();
  }
}
