// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison

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

  static String formatMSISDN(String msisdn) {
    List<int> groupLengths = [3, 2, 2, 2, 2];
    int startIndex = 0;
    List<String> groups = [];

    for (int length in groupLengths) {
      String group = msisdn.substring(startIndex, startIndex + length);
      groups.add(group);
      startIndex += length;
    }
    return groups.join(' ');
  }

  static String parseTimerDuration(Duration duration) {
    String minutesString;
    if (duration.inSeconds > 59) {
      minutesString =
          '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      minutesString =
          '${(duration.inHours % 60).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return minutesString;
  }

  static String capitalizeFirstLetter(String input) {
    if (input == null || input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
}
//if user select flooz over ecobacnk