import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static final _formatter = NumberFormat('#,###', 'id_ID');

  static String formatNumber(dynamic number) {
    return _formatter.format(number);
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String clean = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final number = int.tryParse(clean);
    if (number == null) return newValue;

    final newText = _formatter.format(number);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
