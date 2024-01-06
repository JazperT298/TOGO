// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class BigDecimal {
  static int ROUND_CEILING = 2; // Replace this with your desired rounding mode
  final double _value;

  static const dynamic TEN = null;
  static const dynamic ZERO = null;

  BigDecimal(double value) : _value = value;

  int compareTo(BigDecimal other) {
    return _value.compareTo(other._value);
  }

  @override
  String toString() {
    return _value.toString();
  }

  static BigDecimal parse(String value) {
    return BigDecimal(double.parse(value));
  }

  BigDecimal add(BigDecimal other) {
    return BigDecimal(_value + other._value);
  }

  BigDecimal divide(BigDecimal other) {
    return BigDecimal(_value / other._value);
  }

  BigDecimal setScale(int scale, int roundingMode) {
    // Implement setScale if needed
    return this;
  }
}
