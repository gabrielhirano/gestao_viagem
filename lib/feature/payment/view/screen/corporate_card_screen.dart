import 'package:flutter/material.dart';
import 'package:gestao_viajem/feature/payment/view/widget/credit_card_widget.dart';

class CorporateCardScreen extends StatefulWidget {
  const CorporateCardScreen({super.key});

  @override
  State<CorporateCardScreen> createState() => _CorporateCardScreenState();
}

class _CorporateCardScreenState extends State<CorporateCardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CreditCardWidget(),
    );
  }
}
