import 'package:intl/intl.dart';

class Formatters {
  /// retorna uma valor na forma monetaria:
  ///
  /// 1234.56 => 1.234,56
  static String currencyPtBr(double valor) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    return formatter.format(valor);
  }

  /// retorna a data em dd/MM/yyyy
  static String simpleDate(DateTime valor) {
    final formatter = new DateFormat('dd/MM/yyyy');
    return formatter.format(valor);
  }
}
