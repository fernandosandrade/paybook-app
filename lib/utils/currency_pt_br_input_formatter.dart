import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'formatters.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({required this.maxDigits});
  final int maxDigits;

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    int value = int.parse(newValue.text);
    String newText = "R\$ " + Formatters.currencyPtBr(value);
    return newValue.copyWith(
        text: newText, selection: new TextSelection.collapsed(offset: newText.length));
  }
}
