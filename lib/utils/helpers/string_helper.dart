// ignore_for_file: prefer_interpolation_to_compose_strings

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

  static String formatPhoneNumber(String number) {
    String cleanedNumber = number.replaceAll(RegExp(r'\D'), '');

    if (cleanedNumber.length >= 8) {
      return cleanedNumber.substring(3, 5) +
          ' ' +
          cleanedNumber.substring(5, 7) +
          ' ' +
          cleanedNumber.substring(7, 9) +
          ' ' +
          cleanedNumber.substring(9);
    } else {
      return number;
    }
  }
}
