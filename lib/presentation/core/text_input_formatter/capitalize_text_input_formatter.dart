// Flutter imports:
import 'package:flutter/services.dart';

class CapitalizeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Capitalize the first letter of each word
    return TextEditingValue(
      text: _capitalize(newValue.text),
      selection: newValue.selection,
    );
  }

  String _capitalize(String text) {
    List<String> words = text.split(' ');
    words = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return word;
      }
    }).toList();
    return words.join(' ');
  }
}
