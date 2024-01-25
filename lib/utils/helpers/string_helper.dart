import 'package:intl/intl.dart';

class StringHelper {
  static String formatNumberWithCommas(int number) {
    final format = NumberFormat('#,###');
    String formattedNumber = format.format(number);
    return formattedNumber.replaceAll(',', ' ');
  }
}
