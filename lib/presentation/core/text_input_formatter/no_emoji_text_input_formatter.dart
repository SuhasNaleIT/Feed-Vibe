// Flutter imports:
import 'package:flutter/services.dart';

class NoEmojiTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Regular expression to filter out emojis
    final noEmojiRegex = RegExp('[^\u0020-\u007E\u00A0-\u00FF]');

    // Check if the new value contains emojis
    if (noEmojiRegex.hasMatch(newValue.text)) {
      // If emoji is detected, return the old value
      return oldValue;
    }

    // If no emoji is detected, allow the new value
    return newValue;
  }
}
