import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';

class InputFormApp extends StatefulWidget {
  final String placeholder;

  final int? maxLength;
  final TextInputType? inputType;
  final bool enable;

  final Widget? prefixIcon;
  final Widget? sufixIcon;

  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  final FontWeight? textWeight;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?) validator;
  final Function(String?)? onChanged;
  final bool? obscureText;
  final bool? autoFocus;
  final InputDecoration? inputDecoration;
  final List<TextInputFormatter>? inputFormatters;

  final Function(String?)? onFieldSubmitted;

  const InputFormApp({
    Key? key,
    required this.placeholder,
    required this.controller,
    required this.validator,
    this.prefixIcon,
    this.sufixIcon,
    this.inputType,
    this.obscureText = false,
    this.autoFocus = false,
    this.inputFormatters,
    this.inputDecoration,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLength,
    this.textColor,
    this.textWeight,
    this.borderColor,
    this.onChanged,
    this.backgroundColor,
    this.enable = true,
  }) : super(key: key);

  @override
  State<InputFormApp> createState() => _InputFormAppState();
}

class _InputFormAppState extends State<InputFormApp> {
  bool validateByform = false;

  bool get isNotValidated =>
      widget.validator.call(widget.controller.text) != null ||
      (widget.validator.call(widget.controller.text)?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          alignment: Alignment.topCenter,
          decoration: AppShapes.decoration(
            color: appColors.white,
            customRadius: const BorderRadius.all(Radius.circular(12)),
            border: widget.borderColor != null
                ? ShapesBorder(widget.borderColor!, borderWidth: 2)
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: TextFormField(
              keyboardType: widget.inputType,
              onFieldSubmitted: widget.onFieldSubmitted,
              focusNode: widget.focusNode ?? FocusNode(),
              obscureText: widget.obscureText == true,
              controller: widget.controller,
              inputFormatters: widget.inputFormatters,
              validator: (string) {
                setState(() {
                  validateByform = true;
                });
                return null;
              },
              onChanged: widget.onChanged,
              style: TextStyle(
                  fontSize: 16,
                  color: widget.textColor ?? appColors.colorBrandPrimaryBlue,
                  fontWeight: widget.textWeight ?? FontWeight.bold),
              decoration: widget.inputDecoration ??
                  InputDecoration(
                    enabled: widget.enable,
                    labelText: widget.placeholder,
                    labelStyle: TextStyle(
                        color: appColors.colorTextBlack,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 15, bottom: 10, top: 4, right: 15),
                    prefixIcon: widget.prefixIcon,
                    prefixIconColor: appColors.colorTextBlack,
                    prefixIconConstraints:
                        const BoxConstraints(maxWidth: 80, minWidth: 40),
                    suffixIcon: widget.sufixIcon,
                    filled: true,
                    fillColor: widget.backgroundColor ?? appColors.white,
                    errorStyle: TextStyle(
                      color: appColors.colorFeedbackNegative,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ),
          ),
        ),
        _buildValidateError()
      ],
    );
  }

  _buildValidateError() {
    if (validateByform == false) return const SizedBox.shrink();
    String? errorMessage = widget.validator.call(widget.controller.text);
    if (errorMessage == null) return const SizedBox.shrink();

    validateByform = true;
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: AppText(
        text: errorMessage,
        textStyle: AppTextStyle.paragraphSmallBold,
        textColor: appColors.colorFeedbackNegative,
      ),
    );
  }
}
