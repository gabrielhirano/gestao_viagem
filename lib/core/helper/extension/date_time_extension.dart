import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateTimeExtension on DateTime {
  String formatToBrazilianDate() {
    initializeDateFormatting('pt_BR', null);
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'pt_BR');
    return formatter.format(this);
  }

  String formatToBrazilianTime() {
    initializeDateFormatting('pt_BR', null);
    final DateFormat formatter = DateFormat('HH:mm', 'pt_BR');
    return formatter.format(this);
  }
}
