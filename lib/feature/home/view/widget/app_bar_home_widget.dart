import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_viajem_onfly/core/layout/components/app_text.dart';
import 'package:gestao_viajem_onfly/core/theme/theme_global.dart';
import 'package:gestao_viajem_onfly/core/view/widget/offline_connection_widget.dart';

class AppBarHomeWidget extends StatelessWidget {
  const AppBarHomeWidget({super.key});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: appColors.colorBrandPrimaryBlue,
      shadowColor: appColors.colorBrandPrimaryBlue,
      iconTheme: IconThemeData(color: appColors.white),
      title: Row(
        children: [
          AppText(
            text: 'Onfly',
            textStyle: AppTextStyle.headerH4,
            textColor: appColors.white,
          ),
          const SizedBox(width: 30),
          Observer(builder: (_) {
            return const Visibility(
              // visible: connectivityController.isOffline,
              child: OfflineConnectionWidget(),
            );
          })
        ],
      ),
      actions: const [
        Icon(Icons.notifications),
        SizedBox(width: 20),
        Icon(Icons.person),
        SizedBox(width: 12),
      ],
    );
  }
}
