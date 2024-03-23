import 'package:flutter/material.dart';

import 'package:gestao_viajem_onfly/core/helpers/validator/input_validator.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';

class ExpenseCommentTextField extends StatefulWidget {
  final TextEditingController controller;
  const ExpenseCommentTextField({super.key, required this.controller});

  @override
  State<ExpenseCommentTextField> createState() =>
      _ExpenseCommentTextFieldState();
}

class _ExpenseCommentTextFieldState extends State<ExpenseCommentTextField>
    with InputValidator {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: AppShapes.decoration(
        radius: RadiusSize.medium,
        border: ShapesBorder(appColors.greyLight),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: TextFormField(
          controller: widget.controller,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: 'Insira a mensagem aqui.',
            border: InputBorder.none,
            filled: true,
            fillColor: appColors.white,
          ),
          maxLines: 4,
          minLines: null,
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
            return Container(
              color: appColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: 'Máximo de 100 caracteres',
                    textStyle: AppTextStyle.paragraphSmallBold,
                    textColor: appColors.colorTextBlack,
                  ),
                  AppText(
                    text: '${widget.controller.text.length} / 500',
                    textStyle: AppTextStyle.paragraphSmallBold,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
