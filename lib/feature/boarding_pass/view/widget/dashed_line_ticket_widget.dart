import 'package:flutter/material.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/view/widget/dashed_line_widget.dart';

class DashedLineTicketWidget extends StatelessWidget {
  final Color? mark;
  const DashedLineTicketWidget({super.key, this.mark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 20,
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: AppShapes.decoration(
              color: mark ?? appColors.white,
              radius: RadiusSize.circle,
            ),
          ),
          Expanded(
            child: DashedLineWidget(
              height: 1,
              color: appColors.greyLight,
            ),
          ),
          Container(
            height: 20,
            width: 20,
            decoration: AppShapes.decoration(
              color: mark ?? appColors.white,
              radius: RadiusSize.circle,
            ),
          ),
        ],
      ),
    );
  }
}
