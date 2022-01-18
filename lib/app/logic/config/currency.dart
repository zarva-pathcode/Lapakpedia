import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class CurrencyFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final currency = NumberFormat("### ### ###", "en_us");
    String newText = currency.format(value);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
