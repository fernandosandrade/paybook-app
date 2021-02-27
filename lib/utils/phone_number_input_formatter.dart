import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PhoneNumberInputFormatter extends TextInputFormatter {
  PhoneNumberInputFormatter({this.maxDigits = 9});
  final int maxDigits;

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("###-###-###", "pt_BR");
    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText, selection: new TextSelection.collapsed(offset: newText.length));
  }
}
