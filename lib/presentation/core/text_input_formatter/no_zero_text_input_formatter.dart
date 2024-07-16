// Flutter imports:
import 'package:flutter/services.dart';

class NoZeroTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue,) {
    // Check if the new value contains '0'
    if (newValue.text.contains('0')) {
      // If '0' is present and it's not the first character, accept the new value
      if (newValue.text.indexOf('0') != 0) {
        return newValue;
      }
      // If '0' is the first character, check if it's preceded by another digit
      if (oldValue.text.isEmpty ||
          (oldValue.text.isNotEmpty && int.tryParse(oldValue.text) != null)) {
        return newValue;
      }
      // If '0' is the first character and it's not preceded by another digit, reject the change
      return oldValue.copyWith(text: oldValue.text);
    }
    // If '0' is not present, accept the new value
    return newValue;
  }
}
