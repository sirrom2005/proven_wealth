
import 'package:flutter/services.dart';

class TrnNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    text = text.replaceAll(RegExp(r'(\s)|(\D)'), '');

    int offset = newValue.selection.start;
    var subText =
    newValue.text.substring(0, offset).replaceAll(RegExp(r'(\s)|(\D)'), '');
    int realTrimOffset = subText.length;

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
        buffer.write('-');
      }

      if (nonZeroIndex % 3 == 0 &&
          subText.length == nonZeroIndex &&
          nonZeroIndex > 3) {
        int moveCursorToRigth = nonZeroIndex ~/ 3 - 1;
        realTrimOffset += moveCursorToRigth;
      }

      if (nonZeroIndex % 3 != 0 && subText.length == nonZeroIndex) {
        int moveCursorToRigth = nonZeroIndex ~/ 3;
        realTrimOffset += moveCursorToRigth;
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: realTrimOffset));
  }
}