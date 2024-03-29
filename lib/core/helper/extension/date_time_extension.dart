import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension DateTimeExtension on DateTime {
  String get formatToBrazilianDate {
    initializeDateFormatting('pt_BR', null);
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'pt_BR');
    return formatter.format(this);
  }

  String get formatToBrazilianTime {
    initializeDateFormatting('pt_BR', null);
    final DateFormat formatter = DateFormat('HH:mm', 'pt_BR');
    return formatter.format(this);
  }
}
