import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringHelper {
  static String formatNumberWithCommas(int number) {
    final format = NumberFormat('#,###');
    String formattedNumber = format.format(number);
    return formattedNumber.replaceAll(',', ' ');
  }

  static String formatStringWithSpace(String text, TextEditingController controller) {
    String newText = text.replaceAll(' ', '');
    String spacedText = newText.split('').join(' ');
    controller.value = controller.value.copyWith(
      text: spacedText,
      selection: TextSelection.collapsed(offset: spacedText.length),
    );
    return controller.value.text;
  }
}
