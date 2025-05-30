import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('id');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Hapus semua karakter selain angka
    String numericOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericOnly.isEmpty) return newValue.copyWith(text: '');

    String formatted = _formatter.format(int.parse(numericOnly));

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
