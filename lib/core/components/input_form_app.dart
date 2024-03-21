import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';

class InputFormApp extends StatefulWidget {
  final String? label;
  final String? placeholder;

  final Widget? prefixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?) validator;
  final bool? obscureText;
  final bool? autoFocus;
  final InputDecoration? inputDecoration;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onFieldSubmitted;

  const InputFormApp({
    Key? key,
    this.label,
    this.placeholder,
    this.prefixIcon,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.autoFocus = false,
    this.inputFormatters,
    this.inputDecoration,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  State<InputFormApp> createState() => _InputFormAppState();
}

class _InputFormAppState extends State<InputFormApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.label != null,
          child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                widget.label ?? '',
                style: TextStyle(
                  color: appColors.colorTextBlack,
                  fontWeight: FontWeight.w300,
                ),
              )),
        ),
        const SizedBox(height: 4),
        TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.obscureText == true,
          controller: widget.controller,
          validator: widget.validator,
          style: const TextStyle(fontSize: 14),
          decoration: widget.inputDecoration ??
              InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                border: const OutlineInputBorder(),
                hintText: widget.placeholder,
                prefixIcon: widget.prefixIcon,
                prefixIconColor: appColors.black,
                prefixIconConstraints:
                    const BoxConstraints(maxWidth: 80, minWidth: 40),
                filled: true,
                fillColor: appColors.white,
                errorStyle: TextStyle(
                  color: appColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
        ),
      ],
    );
  }
}
