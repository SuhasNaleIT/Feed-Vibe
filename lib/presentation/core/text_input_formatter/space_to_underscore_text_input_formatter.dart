// Flutter imports:
import 'package:flutter/services.dart';

class SpaceToUnderscoreTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(' ', '_'),
      selection: newValue.selection,
    );
  }
}
