import 'package:intl/intl.dart';

class Formatters {
  /// retorna uma valor na forma monetaria:
  ///
  /// 123456 => 1.234,56
  static String currencyPtBr(int valor) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    return formatter.format(valor / 100);
  }

  /// retorna a data em dd/MM/yyyy
  static String simpleDate(DateTime valor) {
    final formatter = new DateFormat('dd/MM/yyyy');
    return formatter.format(valor);
  }
}
