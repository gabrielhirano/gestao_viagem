import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String get realCurrencyNumber {
    final formater = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return formater.format(this);
  }
}
