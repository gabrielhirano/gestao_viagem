import 'package:flutter/material.dart';
import 'package:gestao_viajem_onfly/core/layout/foundation/app_shapes.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppShapes.decoration(radius: RadiusSize.large),
      height: 200,
      width: 320,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/cartao_cut.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
